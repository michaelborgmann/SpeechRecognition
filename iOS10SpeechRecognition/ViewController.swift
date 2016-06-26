//
//  ViewController.swift
//  iOS10SpeechRecognition
//
//  Created by Michael Borgmann & Sandro Dahl on 26/06/16.
//  Copyright © 2016 Michael Borgmann & Sandro Dahl. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var transcription: UITextView!

    let recordingSession = AVAudioSession.sharedInstance()
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
                /*
                DispatchQueue.main.async {
                    if allowed {
                        self.speechRecognition()
                    } else {
                        // failed to record!
                    }
                }
                */
            }
        } catch {
            // failed to record!
        }
        
    }

    func speechRecognition() {
        let recognizer = SFSpeechRecognizer()
        
        let audioPath = getDocumentsDirectory() + "/recording.m4a"
        
        //let audioFileURL = Bundle.main().urlForResource(audioPath, withExtension: "m4a")
        let audioFileURL = URL(fileURLWithPath: audioPath)
        
        let request = SFSpeechURLRecognitionRequest(url: audioFileURL)
        
        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            // only print final result, not optional variations (best transcription)
            guard let isFinalResult = result?.isFinal where isFinalResult == true else { return }
            print (result?.bestTranscription.formattedString)
        })
         
    }
    

    @IBAction func startRecording(_ sender: AnyObject) {
        let audioFilename = getDocumentsDirectory() + "/recording.m4a"
        let audioURL = URL(fileURLWithPath: audioFilename)
        
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
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        audioRecorder.stop()
        audioRecorder = nil
        speechRecognition()
    }
    
    func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            audioRecorder.stop()
            audioRecorder = nil
        }
    }
}
