//
//  ThreePointGradientView.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 23.05.2021.
//

import UIKit

class ThreePointGradientView: UIView {

    //MARK: PROPERTIES
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private var gradientLayer: CAGradientLayer {
        layer as? CAGradientLayer ?? CAGradientLayer()
    }
    
    var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    var secondColor: UIColor = UIColor.white.withAlphaComponent(0.2) {
        didSet {
            updateView()
        }
    }
    
    var thirdColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    //MARK: INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: FUNCTIONS
    func updateView() {
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    }
    
}
