//
//  HW17GitHubNetworkServiceProtocol.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 02.06.2021.
//

import Foundation

protocol HasGitHubNetworkService {
    var gitHubService: HW17VKNetworkServiceProtocol {get}
}

typealias HW17GetUserInfoApiResponse = Result<Response, HW17NetworkServiceError>

protocol HW17VKNetworkServiceProtocol {
    func authorize(userId: String, accessToken: String, completion: @escaping (Bool) -> ())
    func usersGet(completion: @escaping (HW17GetUserInfoApiResponse) -> ())
    func loadImage(imageUrl: String, completion: @escaping (Data?) -> ())
}
