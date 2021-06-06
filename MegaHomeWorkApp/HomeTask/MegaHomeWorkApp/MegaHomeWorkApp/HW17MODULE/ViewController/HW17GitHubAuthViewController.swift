//
//  HW17GitHubAuthViewController.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 06.06.2021.
//

import UIKit
import WebKit

class HW17GitHubAuthViewController: UIViewController {
    
    var request: URLRequest?
    var networkService: HW17VKNetworkServiceProtocol
    
    lazy var authWebView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(authWebView)
        authWebViewConstraints()
        request = configureRequest()
        print(request)
        authWebView.load(request!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(networkService: HW17VKNetworkServiceProtocol) {
        self.networkService = networkService
        networkService.clearSession()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func authWebViewConstraints() {
        NSLayoutConstraint.activate([
            authWebView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            authWebView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            authWebView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            authWebView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    func configureRequest() -> URLRequest {
        var components = URLComponents(string: HW17StaticInfo.VKMethods.authorize)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: HW17StaticInfo.VKParameters.client_id),
            URLQueryItem(name: "redirect_uri", value: HW17StaticInfo.VKParameters.redirect_uri),
            URLQueryItem(name: "scope", value: "friends, photos"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: HW17StaticInfo.VKParameters.v)
        ]
        //нет времени обрабатывать ошибку :(
        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = "POST"
        return request
    }
    
    private func showAlert(for error: HW17NetworkServiceError) {
        let alert = UIAlertController(title: "Опаньки, что-то пошло не так",
                                      message: message(for: error),
                                      preferredStyle: .alert)
        present(alert, animated: true)
    }
    
    private func message(for error: HW17NetworkServiceError) -> String {
        switch error {
        case .network:
            return "Упал запрос"
        case .decodable:
            return "Не смогли распарсить"
        case .unauthorize:
            return "Вы не авторизованы"
        case .unknown:
            return "????"
        }
    }
}

extension HW17GitHubAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let parameters = fragment.components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, parameters in
                var dictionary = result
                let key = parameters[0]
                let value = parameters[1]
                dictionary[key] = value
                return dictionary
            }
        guard let userId = parameters["user_id"],
              let accessToken = parameters["access_token"]
        else { return }
        
        networkService.authorize(userId: userId, accessToken: accessToken) { isAuthorized in
            switch isAuthorized {
            case true:
                self.networkService.usersGet { result in
                    switch result {
                    case .success(let response):
                        guard let data = response.response.first else { return }
                        self.networkService.loadImage(imageUrl: data.photo_200) { iData in
                            if let iData = iData, let image = UIImage(data: iData) {
                                DispatchQueue.main.async {
                                    let controller = HW17ViewController(networkService: self.networkService)
                                    controller.imageView.image = image
                                    controller.label.text = "\(data.first_name) \(data.last_name) (ID:\(data.id)"
                                }
                            }
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.showAlert(for: error)
                        }
                    }
                }
            case false:
                return
            }
        }
        decisionHandler(.cancel)
    }
}
