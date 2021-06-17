//
//  AppServiceLocator.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 06.06.2021.
//

import Foundation

protocol AppServiceLocatorDependencies: HasGitHubNetworkService, HasImageFilterServiceProtocol {}

class AppServiceLocator: AppServiceLocatorDependencies {
    
    var gitHubService: HW17VKNetworkServiceProtocol = HW17VKNetworkService()
    var imageFilterService: ImageFilterServiceProtocol = ImageFilterService()
    
}
