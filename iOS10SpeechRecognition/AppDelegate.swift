//
//  AppDelegate.swift
//  iOS10SpeechRecognition
//
//  Created by Michael Borgmann & Sandro Dahl on 26/06/16.
//  Copyright © 2016 Michael Borgmann & Sandro Dahl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main().bounds)
        
        // load speec recognition view controller
        let speechVC = SpeechRecognitionViewController(nibName: "SpeechRecognitionView", bundle: nil)
        speechVC.audioRecording = AudioRecording(recordingFile: RecordingFile())
        
        window?.rootViewController = speechVC
        window?.makeKeyAndVisible()
        
        return true
    }
}
