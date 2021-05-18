//
//  Donut.swift
//  10thLessionHomeTask
//
//  Created by Иван Казанцев on 15.05.2021.
//

import UIKit

class Donut: UIView {
    
    let image: UIImage = {
        let image = UIImage(imageLiteralResourceName: "DonutVectorBackground")
        return image
    }()
    var circleRadius: CGFloat = 0
    lazy var donut = CAShapeLayer()
    lazy var innerLine = CAShapeLayer()
    
    func createCircle(bounds: CGRect) {
        let circle: CAShapeLayer = {
            let lineWidth = 60
            let path = UIBezierPath(arcCenter: CGPoint(x: bounds.maxX/2, y: bounds.maxY/2),
                                    radius: CGFloat(Int(bounds.maxX)/2 - lineWidth),
                                    startAngle: CGFloat(0),
                                    endAngle: CGFloat(Double.pi * 2),
                                    clockwise: true)
            
            let shape = CAShapeLayer()
            shape.path = path.cgPath
            shape.lineWidth = 60
            circleRadius = CGFloat(Int(bounds.maxX)/2 - lineWidth/2)
            return shape
        }()
        let dColor = UIColor(patternImage: image)
        circle.strokeColor = dColor.cgColor
        circle.fillColor = UIColor.clear.cgColor
        donut = circle
        
        let innerCircle: CAShapeLayer = {
            let path = UIBezierPath(arcCenter: CGPoint(x: bounds.maxX/2, y: bounds.maxY/2),
                                    radius: CGFloat(60),
                                    startAngle: CGFloat(0),
                                    endAngle: CGFloat(Double.pi * 2),
                                    clockwise: true)
            let shape = CAShapeLayer()
            shape.path = path.cgPath
            return shape
        }()
        innerCircle.fillColor = UIColor.clear.cgColor
        innerLine = innerCircle
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createCircle(bounds: bounds)
        layer.addSublayer(donut)
        layer.addSublayer(innerLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === self {
            return nil
        }
        return view
    }
    
}
