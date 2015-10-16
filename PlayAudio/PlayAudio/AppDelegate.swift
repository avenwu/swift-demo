//
//  AppDelegate.swift
//  PlayAudio
//
//  Created by aven wu on 10/16/15.
//  Copyright (c) 2015 avenwu. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AVAudioPlayerDelegate {

    var window: UIWindow?
    var audioPlayer: AVAudioPlayer?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(dispatchQueue, { [weak self] in
            
            NSNotificationCenter.defaultCenter().addObserver(self!, selector: "handleInterruption:", name: AVAudioSessionInterruptionNotification, object: nil)
            
            var audioSessionError: NSError?
            let audioSession = AVAudioSession.sharedInstance()
            audioSession.setActive(true, error: nil)

            if audioSession.setCategory(AVAudioSessionCategoryPlayback, error: &audioSessionError) {
                println("Sucessfully set the audio session" )
            } else {
                println("Could not set the audio session")
            }
            let filePatch = NSBundle.mainBundle().pathForResource("song", ofType: "mp3")
            let fileData = NSData(contentsOfFile: filePatch!, options: .DataReadingMappedIfSafe,
                error: nil)
            var error: NSError?
            self?.audioPlayer = AVAudioPlayer(data: fileData, error: &error)
            if let theAudioPlayer = self?.audioPlayer {
                theAudioPlayer.delegate = self
                if theAudioPlayer.prepareToPlay() && theAudioPlayer.play() {
                    println("Successfully started playing")
                } else {
                    println("Failed to play")
                }
            }
            })
        return true
    }

    func handleInterruption(notification: NSNotification) {
        let interruptionTypeAsObject = notification.userInfo![AVAudioSessionInterruptionOptionKey] as! NSNumber
        
        let interruptionType = AVAudioSessionInterruptionType(rawValue: interruptionTypeAsObject.unsignedLongValue)
        if let type = interruptionType {
            if type == .Ended {
                
            }
        }
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

