//
//  AppCoordinator.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 06.06.2021.
//

import UIKit

class AppCoordinator {
    typealias Dependencies = HasGitHubNetworkService
    
    var rootViewController: UINavigationController
    
    let serviceLocator: AppServiceLocator
    
    init(rootViewController: UINavigationController, serviceLocator: AppServiceLocator) {
        self.rootViewController = rootViewController
        self.serviceLocator = serviceLocator
    }
    
    func toHW19() {
        let vc = HW19ViewController(imageFilterService: serviceLocator.imageFilterService, appCoordinator: self)
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func toHW17() {
        let vc = HW17ViewController(networkService: serviceLocator.gitHubService)
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func toHW13() {
        let vc = HW13ViewController()
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func showMainController() {
        let vc = ViewController(appCoordinator: self)
        rootViewController.pushViewController(vc, animated: true)
    }
}
