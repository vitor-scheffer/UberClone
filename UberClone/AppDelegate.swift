//
//  AppDelegate.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 28/10/22.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
            
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = UIColor(displayP3Red: 0.067, green: 0.576, blue: 0.604, alpha: 1)
            
            let navigationBar = UINavigationBar.appearance()
            navigationBar.standardAppearance = barAppearance
            navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            // Fallback on earlier versions
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle


}

