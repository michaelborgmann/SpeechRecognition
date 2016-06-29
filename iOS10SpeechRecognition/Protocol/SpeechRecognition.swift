//
//  SpeechRecognition.swift
//  iOS10SpeechRecognition
//
//  Created by Michael Borgmann & Sandro Dahl on 26/06/16.
//  Copyright © 2016 Michael Borgmann & Sandro Dahl. All rights reserved.
//

import Foundation

protocol SpeechRecognition {
    func recognitionResult(completion: (String?) -> ())
}
