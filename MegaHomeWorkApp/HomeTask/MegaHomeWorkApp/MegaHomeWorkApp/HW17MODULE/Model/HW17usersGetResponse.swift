//
//  getUserInfoResponse.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 03.06.2021.
//

import Foundation

struct Response: Decodable {
    let response: [HW17usersGetResponse]
}

struct HW17usersGetResponse: Decodable {
    let first_name: String
    let id: Int
    let last_name: String
    let can_access_closed: Bool
    let is_closed: Bool
    let photo_200: String
}
