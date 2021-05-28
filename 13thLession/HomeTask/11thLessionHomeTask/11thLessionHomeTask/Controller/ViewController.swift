//
//  ViewController.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 19.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
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
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.setTitle("HW13", for: .normal)
        button.addTarget(self, action: #selector(to13HW), for: .touchUpInside)
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
    
//MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(shareButton)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(homeWork13Button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldConstraints()
        shareButtonConstraints()
        buttonAnimConstraints()
        homeWork13ButtonConstraints()
    }
    
//MARK: AUTOLAYOUT
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
        homeWork13Button.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -20).isActive    = true
        homeWork13Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive    = true
        homeWork13Button.widthAnchor.constraint(equalToConstant: 70).isActive                               = true
        homeWork13Button.heightAnchor.constraint(equalToConstant: 70).isActive                              = true
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
    
//    @objc func animate() {
//        UIView.animate(withDuration: 0.2,
//                       delay: 0,
//                       animations: {
//                        self.button.transform = .init(scaleX: 0.9, y: 0.9)
//                       })
//        UIView.animate(withDuration: 1,
//                       delay: 0.2,
//                       usingSpringWithDamping: 0.2,
//                       initialSpringVelocity: 30,
//                       animations: {
//                        self.button.transform = .init(scaleX: 1, y: 1)
//                       })
//    }

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
        let controller = HomeWork13_Animations_ViewController()
        present(controller, animated: true, completion: nil)
    }
    
}

