//
//  RecordingFile.swift
//  iOS10SpeechRecognition
//
//  Created by Michael Borgmann & Sandro Dahl on 26/06/16.
//  Copyright © 2016 Michael Borgmann & Sandro Dahl. All rights reserved.
//

import Foundation

struct RecordingFile {
    let fileName: String = "recording"
    let fileExtension: String = "m4a"
    let pathDir: String = FileManager.cachesDir()
    
    func pathUrl() -> URL {
        return URL(fileURLWithPath: pathDir
            .appending("/")
            .appending(self.fileName)
            .appending(".")
            .appending(self.fileExtension))
    }
}
