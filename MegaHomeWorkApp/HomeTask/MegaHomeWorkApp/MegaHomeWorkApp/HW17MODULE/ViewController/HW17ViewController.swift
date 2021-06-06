//
//  HW17ViewController.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 03.06.2021.
//

import UIKit

class HW17ViewController: UIViewController {
    
    //MARK: - PROPERTIES

    //MARK: - DEPENDENCIES
    private let networkService: HW17VKNetworkServiceProtocol
    

    //MARK: - INIT
    init(networkService: HW17VKNetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - UI
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadData()
        view.addSubview(imageView)
        view.addSubview(label)
        setConstraints()
    }
    //MARK: - LAYOUT SUBVIEWS
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.width - 20)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    //CALLBACK HELL
//    private func loadData() {
//        networkService.authorize { isAuthorized in
//            switch isAuthorized {
//            case true:
//                self.networkService.getUserInfo { response in
//                    switch response {
//                    case .success(let data):
//                        self.networkService.loadImage(imageUrl: data.avatar_url) { iData in
//                            if let iData = iData, let image = UIImage(data: iData) {
//                                DispatchQueue.main.async {
//                                    self.imageView.image = image
//                                    self.label.text = "\(data.name): \(data.id)"
//                                }
//                            }
//                        }
//                    case .failure(let error):
//                        self.showAlert(for: error)
//                    }
//                }
//            case false:
//                self.showAlert(for: .unauthorize)
//            }
//        }
//    }
    
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
