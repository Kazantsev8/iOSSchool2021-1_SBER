//
//  ElasticButton.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 24.05.2021.
//

import UIKit

class ElasticButton: UIButton {
    
    var action: (() -> ())?
    var elasticView: ElasticView!
    
    var overshootAmount: CGFloat = 10 {
        didSet {
            elasticView.overshootAmount = overshootAmount
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        elasticViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func whenButtonIsTapped(action: @escaping () -> ()) {
        self.action = action
        self.addTarget(self, action: #selector(ElasticButton.clicked), for: .touchUpInside)
    }
    
    @objc func clicked() {
        elasticView.animateControlPoints()
        action?()
    }
    
    func setupView() {
        elasticView = ElasticView.init(frame: bounds)
        elasticView.backgroundColor = self.backgroundColor
        elasticView.layer.cornerRadius = 20
        addSubview(elasticView)
        elasticView.isUserInteractionEnabled = false
    }
    
    func elasticViewConstraints() {
        elasticView.translatesAutoresizingMaskIntoConstraints = false
        elasticView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        elasticView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        elasticView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        elasticView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}


