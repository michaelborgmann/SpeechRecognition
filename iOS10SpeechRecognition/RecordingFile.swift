//
//  RecordingFile.swift
//  iOS10SpeechRecognition
//
//  Created by Sandro Dahl on 27.06.16.
//  Copyright © 2016 Michael Borgmann. All rights reserved.
//

import Foundation

struct RecordingFile {
    let fileName: String = "recording"
    let fileExtension: String = "m4a"
    
    lazy var recordingFileName: String = {
        return FileManager.documentsDir()
            .appending("/")
            .appending(self.fileName)
            .appending(".")
            .appending(self.fileExtension)
    }()
}
