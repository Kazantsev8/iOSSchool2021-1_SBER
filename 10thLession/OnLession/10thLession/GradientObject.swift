//
//  GradientObject.swift
//  10thLession
//
//  Created by Иван Казанцев on 14.05.2021.
//

import UIKit

class GradientObject: UIView {

    lazy var gradient: CAGradientLayer = {
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.purple.cgColor,
            UIColor.orange.cgColor,
            UIColor.blue.cgColor,
            UIColor.green.cgColor,
            UIColor.red.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.layer.addSublayer(gradient)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) ")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            gradient.frame = self.bounds
        }
    
}
