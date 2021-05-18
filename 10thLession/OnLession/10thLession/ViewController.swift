//
//  ViewController.swift
//  10thLession
//
//  Created by Иван Казанцев on 14.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var gradient = GradientObject(frame: CGRect(x: 0, y: 0, width: view.frame.maxX, height: view.frame.maxY))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(gradient)
        gradient.addGestureRecognizer(pinchGesture)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    let pinchGesture: UITapGestureRecognizer = {
        let gestureRecogniser = UITapGestureRecognizer()
        gestureRecogniser.addTarget(self, action: #selector(smallGradient))
        return gestureRecogniser
    }()
    
    @objc func smallGradient() {
        gradient.frame = CGRect(origin: view.center, size: CGSize(width: 100, height: 100))
    }

}

