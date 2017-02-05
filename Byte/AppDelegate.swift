//
//  AppDelegate.swift
//  Byte
//
//  Created by Kyle McAlpine on 05/02/2017.
//  Copyright © 2017 Kyle McAlpine. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        FIRAuth.auth()?.signInAnonymously()
        FIRDatabase.database().persistenceEnabled = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: DayTVC())
        window?.makeKeyAndVisible()
        
        return true
    }
}

