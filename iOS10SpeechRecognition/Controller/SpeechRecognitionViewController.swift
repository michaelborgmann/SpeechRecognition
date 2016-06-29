//
//  ViewController.swift
//  iOS10SpeechRecognition
//
//  Created by Michael Borgmann & Sandro Dahl on 26/06/16.
//  Copyright © 2016 Michael Borgmann & Sandro Dahl. All rights reserved.
//

import UIKit
import Speech

class SpeechRecognitionViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var transcription: UITextView!

    
    // MARK: Properties
    
    var audioRecording: AudioRecording?
    
    
    // MARK: Init
    
    convenience init(with audioRecording: AudioRecording) {
        self.init()
        self.audioRecording = audioRecording
    }
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioRecording?.delegate = self
    }
    
    
    // MARK: IBActions

    @IBAction func startRecording(_ sender: AnyObject) {
        audioRecording?.start()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        audioRecording?.stop()
    }
    

    // MARK: Privat
    
    private func startSpeechRecognition(recordingFile: RecordingFile) {
        let speechRecognitionHelper = SFSpeechRecognitionHelper(url: recordingFile.pathUrl())
        
        speechRecognitionHelper.recognitionResult { result in
            guard let speechText = result else { return }
            self.transcription.text = speechText
        }
    }
}

extension SpeechRecognitionViewController: AudioRecordingDelegate {
    
    func didFinishedRecoring(result file: RecordingFile) {
       self.startSpeechRecognition(recordingFile: file)
    }
}
