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
    
    func showHW17Controller() {
        let vc = HW17ViewController(networkService: serviceLocator.gitHubService)
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func showHW13Controller() {
        let vc = HW13ViewController()
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func showMainController() {
        let vc = ViewController()
        rootViewController.pushViewController(vc, animated: true)
    }
}
