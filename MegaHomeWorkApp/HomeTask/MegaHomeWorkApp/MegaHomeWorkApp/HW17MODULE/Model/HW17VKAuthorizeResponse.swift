//
//  HW17GitHubAuthorizeResponse.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 02.06.2021.
//

import Foundation

struct HW17VKAuthorizeResponse: Decodable {
    var accessToken: String
    var userId: String
    
    init(accessToken: String, userId: String) {
        self.accessToken = accessToken
        self.userId = userId
    }
}
