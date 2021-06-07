//
//  HW17GitHubNetworkService.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 02.06.2021.
//

import Foundation

final class HW17VKNetworkService {
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private var authorizeResponse = HW17VKAuthorizeResponse(accessToken: "", userId: "")
    
    deinit {
        print("HW17GitHubNetworkService deinit")
    }
}

extension HW17VKNetworkService: HW17VKNetworkServiceProtocol {
    typealias Handler = (Data?, URLResponse?, Error?) -> ()
    //MARK: - AUTHORIZE
    func authorize(userId: String, accessToken: String, completion: @escaping (Bool) -> ()) {
        authorizeResponse.userId = userId
        authorizeResponse.accessToken = accessToken
        if authorizeResponse.accessToken != "",
           authorizeResponse.userId != "" {
            completion(true)
        }
        else { completion(false) ; return }
    }
    //MARK: - GET USER INFO
    func usersGet(completion: @escaping (HW17GetUserInfoApiResponse) -> ()) {
        //COMBINE URL
        var components = URLComponents(string: HW17StaticInfo.VKMethods.usersGet)
        print(authorizeResponse.accessToken, authorizeResponse.userId)
        components?.queryItems = [
            URLQueryItem(name: "fields", value: "first_name, id, last_name, photo_200"),
            URLQueryItem(name: "user_ids", value: authorizeResponse.userId),
            URLQueryItem(name: "access_token", value: authorizeResponse.accessToken),
            URLQueryItem(name: "v", value: "5.131")
        ]
        //CHECK URL
        guard let url = components?.url else { completion(.failure(.unknown)) ; return }
        //CREATE A REQUEST
        var request = URLRequest(url: url)
        request.addValue("Bearer \(authorizeResponse.accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //HANDLER
        let handler: Handler = { rawData, response, taskError in
            do {
                guard let data = rawData else { return }
                let response = try self.decoder.decode(Response.self, from: data)
                print(response)
                completion(.success(response))
            } catch {
                completion(.failure(.unknown))
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    //MARK: - LOAD IMAGE
    func loadImage(imageUrl: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: imageUrl) else { completion(nil) ; return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let handler: Handler = { rawData, response, taskError in
            do {
                completion(rawData)
            } catch {
                completion(nil)
            }
        }
        let dataTask = session.dataTask(with: request, completionHandler: handler)
        dataTask.resume()
    }
    
}
