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
    
    private var authorizeResponse: HW17VKAuthorizeResponse?
    
    deinit {
        print("HW17GitHubNetworkService deinit")
    }
}

extension HW17VKNetworkService: HW17VKNetworkServiceProtocol {
    typealias Handler = (Data?, URLResponse?, Error?) -> ()
    //MARK: - AUTHORIZE
    func authorize(userId: String, accessToken: String, completion: @escaping (Bool) -> ()) {
        self.authorizeResponse?.accessToken = accessToken
        self.authorizeResponse?.userId = userId
        completion(true)
    }
    
    func clearSession() {
        self.authorizeResponse?.accessToken = ""
        self.authorizeResponse?.userId = ""
    }
    //MARK: - GET USER INFO
    func usersGet(completion: @escaping (HW17GetUserInfoApiResponse) -> ()) {
        var components = URLComponents(string: HW17StaticInfo.VKMethods.usersGet)
        
        components?.queryItems = [
            URLQueryItem(name: "fields", value: "id, photo_200"),
            URLQueryItem(name: "access_token", value: authorizeResponse?.accessToken),
            URLQueryItem(name: "user_ids", value: authorizeResponse?.userId),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = components?.url else { completion(.failure(.unknown)) ; return }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(authorizeResponse?.accessToken)", forHTTPHeaderField: "Authorization")
        //request.httpMethod = "GET"
        
        let handler: Handler = { rawData, response, taskError in
            do {
                guard let data = rawData else { return }
                //let data = try self.httpResponse(data: rawData, response: response)
                let response = try self.decoder.decode(Response.self, from: data)
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
                let data = try self.httpResponse(data: rawData, response: response)
                completion(data)
            } catch {
                completion(nil)
            }
        }
        let dataTask = session.dataTask(with: request, completionHandler: handler)
        dataTask.resume()
    }
    
    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
            throw HW17NetworkServiceError.network
        }
        return data
    }
    
    
}
