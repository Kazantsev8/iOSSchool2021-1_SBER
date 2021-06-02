//
//  Donut.swift
//  10thLessionHomeTask
//
//  Created by Иван Казанцев on 15.05.2021.
//

import UIKit

class Donut: UIView {
    //MARK: - VIEWS AND PROPERTIES
    //picture, that fill donut
    let image: UIImage = {
        let image = UIImage(imageLiteralResourceName: "DonutVectorBackground")
        return image
    }()
    //radius of external circle of donut
    var externalCircleRadius: CGFloat = 0
    //radius of internal circle of donut
    var internalCircleRadius: CGFloat = 0
    //donut
    lazy var donutLayer: CAShapeLayer = {
        let path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.midX,
                                                   y: self.bounds.midY),
                                radius: internalCircleRadius + ((externalCircleRadius - internalCircleRadius) / 2),
                                startAngle: CGFloat(0),
                                endAngle: CGFloat(Double.pi * 2),
                                clockwise: true)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = externalCircleRadius - internalCircleRadius
        layer.strokeColor = UIColor(patternImage: image).cgColor
        return layer
    }()
    //center of donut
    lazy var holeLayer: CAShapeLayer = {
        let path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.midX,
                                                   y: self.bounds.midY),
                                radius: internalCircleRadius,
                                startAngle: CGFloat(0),
                                endAngle: CGFloat(Double.pi * 2),
                                clockwise: true)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    //MARK: - INITIALIZERS
    //custom init for main init
    convenience init(x: CGFloat,
                     y: CGFloat,
                     externalCircleRadius: CGFloat,
                     internalCircleRadius: CGFloat) {
        self.init(frame: CGRect(x: x - externalCircleRadius,
                                y: y - externalCircleRadius,
                                width: externalCircleRadius * 2,
                                height: externalCircleRadius * 2))
        self.externalCircleRadius = externalCircleRadius
        self.internalCircleRadius = internalCircleRadius
        setupView()
    }
    //MARK: - METHODS
    //setup view
    private func setupView() {
        self.backgroundColor = .clear
        self.layer.addSublayer(donutLayer)
        self.layer.addSublayer(holeLayer)
    }
    //checking touch inside center of donut
    private func touchIn(point: CGPoint) -> Bool {
        guard let path = holeLayer.path else { return false }
        if path.contains(point) {
            return false
        }
        return true
    }
    //overriding hit test
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard isUserInteractionEnabled else { return nil }
        guard !isHidden else { return nil }
        guard touchIn(point: point) else { return nil }
        
        return super.hitTest(point, with: event)
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        guard isUserInteractionEnabled else { return nil }
//        guard !isHidden else { return nil }
//        guard pointInsideDonut(point: point) else { return nil }
//        let view = super.hitTest(point, with: event)
//        if view === self {
//            return nil
//        }
//        return view
//    }
    
}
