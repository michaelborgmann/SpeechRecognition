//
//  SpeechRecognition.swift
//  iOS10SpeechRecognition
//
//  Created by Sandro Dahl on 27.06.16.
//  Copyright © 2016 Michael Borgmann. All rights reserved.
//

import Foundation

protocol SpeechRecognition {
    func recognitionResult(completion: (String?) -> ())
}
