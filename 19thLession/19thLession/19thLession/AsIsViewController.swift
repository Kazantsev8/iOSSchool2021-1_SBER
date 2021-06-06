//
//  AsIsViewController.swift
//  19thLession
//
//  Created by Иван Казанцев on 04.06.2021.
//

import UIKit

class AsIsViewController: UIViewController {
    
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
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(imageView)
        view.addSubview(slider)
    }
    
    func constraints() {
        
        imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive   = true
        imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive           = true
        imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                          constant: -150).isActive                                          = true
        
        slider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive                        = true
        slider.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive                 = true
        slider.widthAnchor.constraint(equalToConstant: 150).isActive                                        = true
        slider.heightAnchor.constraint(equalToConstant: 30).isActive                                        = true
    }

}
