//
//  ViewController.swift
//  10thLessionHomeTask
//
//  Created by Иван Казанцев on 15.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    var buttonRadius: CGFloat?
    lazy var responderButton: UIButton = {
        let button = UIButton(frame: CGRect(x: view.frame.midX - buttonRadius! / 2,
                                            y: view.frame.midY - buttonRadius! / 2,
                                            width: buttonRadius!,
                                            height: buttonRadius!))
        button.backgroundColor = .clear
        button.layer.cornerRadius = buttonRadius! / 2
        button.addTarget(self, action: #selector(responderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var donutView: Donut = {
        let donut = Donut(frame: CGRect(x: view.frame.midX - 150,
                                        y: view.frame.midY - 150,
                                        width: 300,
                                        height: 300))
        buttonRadius = donut.circleRadius
        return donut
    }()
    
    lazy var popUpView: PopUpView = {
        let popUpView = PopUpView(frame: CGRect(origin: CGPoint(x: view.frame.midX - (view.frame.maxX - 40) / 2,
                                                                y: view.frame.midY - 50),
                                                size: CGSize(width: view.frame.maxX - 40,
                                                             height: 100)))
        popUpView.isHidden = true
        return popUpView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(donutView)
        view.addSubview(responderButton)
        view.addSubview(popUpView)
        view.insertSubview(responderButton, belowSubview: donutView)
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(responderButtonTapped))
        //self.responderButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func responderButtonTapped() {
        //let touchPoint = UIGestureRecognizer().location(in: responderButton)
        
        
        if popUpView.isHidden {
            popUpView.activate()
        }
    }


}

