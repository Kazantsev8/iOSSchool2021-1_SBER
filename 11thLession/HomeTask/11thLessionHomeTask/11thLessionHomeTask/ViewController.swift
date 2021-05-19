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
        return control
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.center = self.view.center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder = "Enter text to share (or try use empty)"
        return textField
    }()
    
//MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(shareButton)
        view.addSubview(textField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textFieldConstraints()
        buttonConstraints()
    }
    
//MARK: AUTOLAYOUT
    func textFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints                                                 = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive              = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive           = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height/2).isActive    = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive                                     = true
    }
    
    func buttonConstraints() {
        shareButton.translatesAutoresizingMaskIntoConstraints                                            = false
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive          = true
        shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive         = true
        shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive      = true
        shareButton.heightAnchor.constraint(equalToConstant: 50).isActive                                = true
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
    
}

