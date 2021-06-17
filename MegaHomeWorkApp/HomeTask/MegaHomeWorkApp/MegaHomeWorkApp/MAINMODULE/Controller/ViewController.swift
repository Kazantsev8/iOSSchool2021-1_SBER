//
//  ViewController.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 19.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
//MARK: PROPERTIES
    var appCoordinator: AppCoordinator
    
//MARK: INSTANCES
    lazy var shareButton: ShareButtonControl = {
        let control = ShareButtonControl()
        control.button.addTarget(self, action: #selector(share), for: .touchUpInside)
        control.button.layer.cornerRadius = 10
        return control
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Animated", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(keyFrameAnimate), for: .touchUpInside)
        return button
    }()
    
    lazy var homeWork13Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.setTitle("HW13", for: .normal)
        button.addTarget(self, action: #selector(to13HW), for: .touchUpInside)
        return button
    }()
    
    lazy var homeWork17Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.setTitle("HW17", for: .normal)
        button.addTarget(self, action: #selector(to17HW), for: .touchUpInside)
        return button
    }()
    
    lazy var homeWork19Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.setTitle("HW19", for: .normal)
        button.addTarget(self, action: #selector(to19HW), for: .touchUpInside)
        return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.center = self.view.center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder = "Enter text to share (or try use empty)"
        return textField
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: CGRect(x: 15,
                                             y: 15,
                                             width: UIScreen.main.bounds.width - 30,
                                             height: UIScreen.main.bounds.height - 30))
        view.layer.cornerRadius = 10
        return view
    }()
    
//MARK: INIT
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(shareButton)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(homeWork13Button)
        view.addSubview(homeWork17Button)
        view.addSubview(homeWork19Button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldConstraints()
        shareButtonConstraints()
        buttonAnimConstraints()
        homeWork17ButtonConstraints()
        homeWork13ButtonConstraints()
        homeWork19ButtonConstraints()
    }
    
//MARK: AUTOLAYOUT
    var hwButtonHeight = 70
    var hwButtonHeightAndOffset = 90
    func textFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints                                                 = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive              = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive           = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height/2).isActive    = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive                                     = true
    }
    
    func shareButtonConstraints() {
        let guide = view.safeAreaLayoutGuide
        shareButton.translatesAutoresizingMaskIntoConstraints                                            = false
        shareButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20).isActive         = true
        shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive         = true
        shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive      = true
        shareButton.heightAnchor.constraint(equalToConstant: 50).isActive                                = true
    }
    
    func buttonAnimConstraints() {
        let guide = view.safeAreaLayoutGuide
        button.translatesAutoresizingMaskIntoConstraints                                            = false
        button.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20).isActive                = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive         = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive      = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive                                = true
    }
    
    func homeWork13ButtonConstraints() {
        homeWork13Button.translatesAutoresizingMaskIntoConstraints                                          = false
        homeWork13Button.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -(CGFloat(2 * hwButtonHeightAndOffset))).isActive = true
        homeWork13Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive    = true
        homeWork13Button.widthAnchor.constraint(equalToConstant: 70).isActive                               = true
        homeWork13Button.heightAnchor.constraint(equalToConstant: 70).isActive                              = true
    }
    
    func homeWork17ButtonConstraints() {
        homeWork17Button.translatesAutoresizingMaskIntoConstraints                                          = false
        homeWork17Button.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -(CGFloat(hwButtonHeightAndOffset))).isActive    = true
        homeWork17Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive    = true
        homeWork17Button.widthAnchor.constraint(equalToConstant: 70).isActive                               = true
        homeWork17Button.heightAnchor.constraint(equalToConstant: 70).isActive                              = true
    }
    
    func homeWork19ButtonConstraints() {
        homeWork19Button.translatesAutoresizingMaskIntoConstraints                                          = false
        homeWork19Button.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -20).isActive    = true
        homeWork19Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive    = true
        homeWork19Button.widthAnchor.constraint(equalToConstant: 70).isActive                               = true
        homeWork19Button.heightAnchor.constraint(equalToConstant: 70).isActive                              = true
    }
    
//MARK: ANIMATIONS
    @objc func basicAnimate() {
        button.layer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 1.5
        animation.repeatCount = 3
        button.layer.add(animation, forKey: "basicAnimation")
    }
    
    @objc func keyFrameAnimate() {
        button.layer.removeAllAnimations()
        let animation = CAKeyframeAnimation(keyPath: "position")
        let pathArray = [[0, button.frame.height / 2], [view.bounds.maxX - button.frame.width, 0]]
        animation.values = pathArray
        animation.duration = 5
        button.layer.add(animation, forKey: "keyFrameAnimation")
    }
    
    @objc func transitionAnimate() {
        button.layer.removeAllAnimations()
    }

//MARK: METHODS
    @objc func share(_ sender: ShareButtonControl) {
        let text = self.textField.text
        let activity = CustomActivity()
        
        if text?.count == 0 {
            let message = "Please enter text."
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
        let activityController = UIActivityViewController(activityItems: [self.textField.text ?? "nil"],
                                                          applicationActivities: [activity])
        
        present(activityController, animated: true, completion: nil)
    }
    
    @objc func to13HW() {
        let controller = HW13ViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func to17HW() {
        let controller = HW17GitHubAuthViewController(networkService: HW17VKNetworkService())
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func to19HW() {
        appCoordinator.toHW19()
    }
}

