//
//  LoadingView.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 23.05.2021.
//

import UIKit

class LoadingView: UIView {

    //MARK: PROPERTIES
    private var activityIndicatorView: UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.startAnimating()
        view.center = CGPoint(x: bounds.midX, y: bounds.midY)
        return view
    }
    
    lazy var gradientView: ThreePointGradientView = {
        let view = ThreePointGradientView(frame: CGRect(origin: CGPoint(x: 0,
                                                                        y: bounds.height - 100),
                                                        size: CGSize(width: bounds.width,
                                                                     height: 100)))
        return view
    }()
    
    private var isPresenting: Bool = false
    
    //MARK: INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGreen
        self.alpha = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: LOADING VIEW LIFE CYCLE
    func present() {
        fadeIn()
    }
    
    func dismiss() {
        guard isPresenting == true else { return }
        fadeOut()
    }
    
    //MARK: FUNCTIONS
    private func fadeIn() {
        UIView.animate(withDuration: 0,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        //self.alpha = 1
                       }) { _ in
            self.dropShadow()
            self.addSubview(self.activityIndicatorView)
            self.addSubview(self.gradientView)
            self.isPresenting = true
        }
    }
    
    private func fadeOut() {
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.isHidden = true
                       }) { _ in
            self.removeFromSuperview()
            self.isPresenting = false
        }
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 1
        layer.cornerRadius = 10
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
}
