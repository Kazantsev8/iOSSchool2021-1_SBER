//
//  AppDelegate.swift
//  19thLession
//
//  Created by Иван Казанцев on 04.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AsIsViewController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

