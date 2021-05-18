//
//  PopUpView.swift
//  10thLessionHomeTask
//
//  Created by Иван Казанцев on 16.05.2021.
//

import UIKit

class PopUpView: UIView {
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("close", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .red
        button.alpha = 0.6
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "You pressed in center of donut"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(okButton)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        alpha = 0.8
        okButtonConstraints()
        textLabelConstraints()
    }
    
    @objc func okButtonTapped() {
        if !self.isHidden {
            self.isHidden = true
        }
    }
    
    func okButtonConstraints() {
        okButton.translatesAutoresizingMaskIntoConstraints                                          = false
        okButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive       = true
        okButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive    = true
        okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive        = true
    }
    
    func textLabelConstraints() {
        textLabel.translatesAutoresizingMaskIntoConstraints                                         = false
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive      = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive   = true
        textLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -10).isActive      = true
        textLabel.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    func activate() {
        self.isHidden = false
    }


}
