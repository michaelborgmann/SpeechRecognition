//
//  ViewController.swift
//  iOS10SpeechRecognition
//
//  Created by Michael Borgmann & Sandro Dahl on 26/06/16.
//  Copyright © 2016 Michael Borgmann & Sandro Dahl. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class ViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: IBOutlets
    
    @IBOutlet weak var transcription: UITextView!

    // MARK: Properties
    
    let recordingSession = AVAudioSession.sharedInstance()
    var audioRecorder: AVAudioRecorder!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIXME: Ask only for permission when record button is used
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
            }
        } catch {
            // failed to record!
        }
    }
    
    // MARK: IBActions

    @IBAction func startRecording(_ sender: AnyObject) {
        handleStartRecording()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        handleStopRecording()
    }
    
    // MARK: Privat
    private func handleStartRecording() {
        var recordingFile = RecordingFile()
        let audioURL = URL(fileURLWithPath: recordingFile.recordingFileName)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            //finishRecording(success: false)
        }
    }
    
    private func handleStopRecording() {
        stopRecorder()
        var recordingFile = RecordingFile()

        let speechRecognitionHelper = SFSpeechRecognitionHelper(url: URL(fileURLWithPath: recordingFile.recordingFileName))
    
        speechRecognitionHelper.recognitionResult { result in
            guard let speechText = result else { return }
            self.transcription.text = speechText
        }
    }
    
    private func stopRecorder() {
        
        if audioRecorder != nil {
            audioRecorder.stop()
            audioRecorder = nil
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            stopRecorder()
        }
    }
}
