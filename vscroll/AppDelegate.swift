//
//  AppDelegate.swift
//  vscroll
//
//  Created by Russell Harrower on 17/8/20.
//  Copyright © 2020 Russell Harrower. All rights reserved.
//

import UIKit
import AVKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        MusicPlayer.shared.startBackgroundMusic(url:"http://stream.radiomedia.com.au:8003/stream", type: "radio")
        setupNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    //CUSTOM CODE
    
    func setupNotifications() {
           // Get the default notification center instance.
           let nc = NotificationCenter.default
           nc.addObserver(self,
                          selector: #selector(handleInterruption),
                          name: AVAudioSession.interruptionNotification,
                          object: nil)
       }
       
       @objc func handleInterruption(notification: Notification) {

           guard let userInfo = notification.userInfo,
               let interruptionTypeRawValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
               let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeRawValue) else {
               return
           }

           switch interruptionType {
           case .began:
               print("interruption began")
           case .ended:
            MusicPlayer.shared.player?.play()
               print("interruption ended")
           default:
               print("UNKNOWN")
           }

       }


}

