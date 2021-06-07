//
//  StaticInfo.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 02.06.2021.
//

enum HW17StaticInfo {
    enum VKKeys {
        static let secret_key = "yakAnAPEGSTLKp0ahZNl"
        static let service_key = "2d8c11232d8c11232d8c11234c2df4322b22d8c2d8c11234d30f27124e0753dbe7208c2"
        static var access_token: String?
        static var user_id: String?
    }
    
    enum VKMethods {
        static let authorize = "https://oauth.vk.com/authorize/"
        static let usersGet = "https://api.vk.com/method/users.get"
    }
    
    enum VKParameters {
        static let client_id = "7873288"
        static let redirect_uri = "https://oauth.vk.com/blank.html"
        static let response_type = "token"
        static let v = "5.131"
    }
}
