//
//  SecondViewController.swift
//  19thLession
//
//  Created by Иван Казанцев on 04.06.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 3
        slider.minimumValue = 1
        slider.addTarget(self, action: #selector(buttonTapped), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(slider)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
    
    @objc func buttonTapped(value: CGFloat) {
        imageView.transform = CGAffineTransform(scaleX: CGFloat(slider.value), y: CGFloat(slider.value))
    }
    
    func setupConstraints() {
        
    }
    

}
