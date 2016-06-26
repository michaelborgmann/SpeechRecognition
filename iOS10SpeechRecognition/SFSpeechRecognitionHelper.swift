//
//  SFSpeechRecognitionHelper.swift
//  iOS10SpeechRecognition
//
//  Created by Sandro Dahl on 27.06.16.
//  Copyright © 2016 Michael Borgmann. All rights reserved.
//

import Foundation
import Speech

struct SFSpeechRecognitionHelper: SpeechRecognition {
    
    let url: URL
    let recognizer = SFSpeechRecognizer()
    
    func recognitionResult(completion: (String?) -> ()) {
        let request = SFSpeechURLRecognitionRequest(url: url)
        
        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            // only use final result, not optional variations (best transcription)
            guard let isFinalResult = result?.isFinal where isFinalResult == true else { return completion(nil) }
            return completion(result?.bestTranscription.formattedString)
        })
    }
}
