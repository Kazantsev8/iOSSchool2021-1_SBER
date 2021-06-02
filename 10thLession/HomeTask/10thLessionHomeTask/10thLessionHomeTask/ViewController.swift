//
//  ViewController.swift
//  10thLessionHomeTask
//
//  Created by Иван Казанцев on 15.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - VIEWS
    //button under donut
    lazy var responderButton: UIButton = {
        let button = UIButton(frame: CGRect(x: self.view.bounds.midX - donutView.internalCircleRadius,
                                            y: self.view.bounds.midY - donutView.internalCircleRadius,
                                            width: donutView.internalCircleRadius * 2,
                                            height: donutView.internalCircleRadius * 2))
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(responderButtonTapped), for: .touchUpInside)
        return button
    }()
    //donut
    lazy var donutView: Donut = {
        let donut = Donut(x: self.view.bounds.midX,
                          y: self.view.bounds.midY,
                          externalCircleRadius: self.view.bounds.midX ,
                          internalCircleRadius: self.view.bounds.midX * 0.5)
        return donut
    }()
    //view, that pop up when touch inside donut
    lazy var popUpView: PopUpView = {
        let popUpView = PopUpView(frame: CGRect(origin: CGPoint(x: view.frame.midX - (view.frame.maxX - 40) / 2,
                                                                y: view.frame.midY - 50),
                                                size: CGSize(width: view.frame.maxX - 40,
                                                             height: 100)))
        popUpView.isHidden = true
        return popUpView
    }()
    
    //MARK: - VIEW CONTROLLER LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(donutView)
        view.addSubview(responderButton)
        view.addSubview(popUpView)
        view.insertSubview(responderButton, belowSubview: donutView)
    }
    
    //MARK: - METHODS
    @objc func responderButtonTapped() {
        if popUpView.isHidden {
            popUpView.activate()
        }
    }


}

