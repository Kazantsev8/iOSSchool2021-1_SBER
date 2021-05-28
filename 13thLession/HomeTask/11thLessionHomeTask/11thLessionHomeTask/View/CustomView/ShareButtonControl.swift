//
//  ShareButtonControl.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 19.05.2021.
//

import UIKit

class ShareButtonControl: UIControl {

    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Share something", for: .normal)
        button.alpha = 1
        button.layer.cornerRadius = 20
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
    }
    
    override func layoutSubviews() {
        buttonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

}
