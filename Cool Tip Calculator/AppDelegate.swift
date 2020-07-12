//
//  AppDelegate.swift
//  Cool Tip Calculator
//
//  Created by Karol Phung on 7/11/20.
//  Copyright © 2020 Karol Phung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let store = UserDefaults.standard
        if let terminateDate = store.object(forKey: "terminateDate") as? Date {
            let timePassed = abs(terminateDate.timeIntervalSince(Date()))
            if (timePassed <= 300) {
                store.set(true, forKey: "showLastBill")
            }
            else {
                store.set(false, forKey: "showLastBill")
            }
        }
        
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

    func applicationWillTerminate(_ application: UIApplication) {
        let store = UserDefaults.standard
        store.set(Date(), forKey: "terminateDate")
    }
}

