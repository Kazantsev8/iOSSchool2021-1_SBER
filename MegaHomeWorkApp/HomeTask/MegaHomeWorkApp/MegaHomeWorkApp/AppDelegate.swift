//
//  AppDelegate.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 19.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let serviceLocator = AppServiceLocator()
        self.coordinator = AppCoordinator(rootViewController: navigationController, serviceLocator: serviceLocator)
        self.coordinator?.showMainController()
        
        return true
    }

}

