//
//  ElasticView.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 24.05.2021.
//

import UIKit

class ElasticView: UIView {

    private let topControlPointView = UIView()
    private let leftControlPointView = UIView()
    private let bottomControlPointView = UIView()
    private let rightControlPointView = UIView()
    
    private let elasticShape = CAShapeLayer()
    
    var overshootAmount: CGFloat = 10.0
    
    private lazy var displayLink : CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(updateLoop))
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
        return displayLink
    }()
    
    override var backgroundColor: UIColor? {
        willSet {
            if let newValue = newValue {
                elasticShape.fillColor = newValue.cgColor
                super.backgroundColor = UIColor.clear
            }
        }
    }
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupComponents() {
        elasticShape.fillColor = UIColor.clear.cgColor
        elasticShape.path = UIBezierPath(rect: self.bounds).cgPath
        layer.addSublayer(elasticShape)
        for controlPoint in [topControlPointView, leftControlPointView, bottomControlPointView, rightControlPointView] {
            addSubview(controlPoint)
            controlPoint.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height)
            //controlPoint.backgroundColor = UIColor.white
        }
        positionControlPoints()
        //backgroundColor = .clear
        clipsToBounds = false
    }

    private func positionControlPoints(){
        topControlPointView.center = CGPoint(x: bounds.midX, y: 0.0)
        leftControlPointView.center = CGPoint(x: 0.0, y: bounds.midY)
        bottomControlPointView.center = CGPoint(x:bounds.midX, y: bounds.maxY)
        rightControlPointView.center = CGPoint(x: bounds.maxX, y: bounds.midY)
    }
    
    private func bezierPathForControlPoints() -> CGPath {
        let path = UIBezierPath()

        let top = topControlPointView.layer.presentation()?.position
        let left = leftControlPointView.layer.presentation()?.position
        let bottom = bottomControlPointView.layer.presentation()?.position
        let right = rightControlPointView.layer.presentation()?.position

        let width = frame.size.width
        let height = frame.size.height
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: 0), controlPoint: top!)
        path.addQuadCurve(to: CGPoint(x: width, y: height), controlPoint: right!)
        path.addQuadCurve(to: CGPoint(x: 0, y: height), controlPoint: bottom!)
        path.addQuadCurve(to: CGPoint(x: 0, y: 0), controlPoint: left!)

        return path.cgPath
    }
    
    @objc func updateLoop() {
        elasticShape.path = bezierPathForControlPoints()
    }
    
    private func startUpdateLoop() {
        displayLink.isPaused = false
    }
      
    private func stopUpdateLoop() {
        displayLink.isPaused = true
    }
    
    func animateControlPoints() {
        startUpdateLoop()
        let overshootAmount = self.overshootAmount
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1.5,
                       options: .curveEaseIn,
                       animations: {
                        self.topControlPointView.center.y -= overshootAmount
                        self.leftControlPointView.center.x -= overshootAmount
                        self.bottomControlPointView.center.y += overshootAmount
                        self.rightControlPointView.center.x += overshootAmount
                       },
                       completion: { _ in
                            UIView.animate(withDuration: 0.45, delay: 0.0, usingSpringWithDamping: 0.15,                      initialSpringVelocity: 5.5,
                                           options: .curveEaseIn,
                                           animations: {
                                            self.positionControlPoints()
                                           },
                                           completion: { _ in
                                            self.stopUpdateLoop()
                                           })
                       })
    }

}
