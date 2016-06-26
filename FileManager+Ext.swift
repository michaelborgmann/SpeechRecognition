//
//  FileManager+Ext.swift
//  iOS10SpeechRecognition
//
//  Created by Sandro Dahl on 26.06.16.
//  Copyright © 2016 Michael Borgmann. All rights reserved.
//

import Foundation

extension FileManager {
    
    class func documentsDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
        
    class func cachesDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}
