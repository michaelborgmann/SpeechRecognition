//
//  AudioRecording.swift
//  iOS10SpeechRecognition
//
//  Created by Sandro Dahl on 29.06.16.
//  Copyright © 2016 Michael Borgmann. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioRecordingDelegate {
    func didFinishedRecoring(result: RecordingFile)
}

class AudioRecording: NSObject, Recording {
    
    let recordingSession = AVAudioSession.sharedInstance()
    var audioRecorder: AVAudioRecorder!
    
    var delegate: AudioRecordingDelegate?
    
    var recordingFile: RecordingFile
    
    init(recordingFile: RecordingFile) {
        self.recordingFile = recordingFile
    }
    
    func start() {
        let audioURL = recordingFile.pathUrl()
        
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
        } catch { }
    }
    
    func stop() {
        if audioRecorder != nil {
            audioRecorder.stop()
            audioRecorder = nil
        }
    }
}

extension AudioRecording: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            self.stop()
        } else {
            delegate?.didFinishedRecoring(result: recordingFile)
        }
    }
}
