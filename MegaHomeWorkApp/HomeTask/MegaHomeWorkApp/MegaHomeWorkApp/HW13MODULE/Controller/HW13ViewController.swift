//
//  HomeWork13_Animations_ViewController.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 24.05.2021.
//

import UIKit

class HW13ViewController: UIViewController {

//MARK: PROPERTIES AND VIEWS
    var animationState: AnimationState = .none
    var dayState: DayState = .day
    
    let nightBackgroundColor: UIColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    let dayBackgroundColor: UIColor = .systemYellow
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to animations"
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 25)
        label.lineBreakMode = .byWordWrapping
        label.alpha = 0
        return label
    }()
    //MARK: STARTBUTTON
    lazy var startButtonElastic: ElasticButton = {
        var button = ElasticButton(frame: .zero)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemRed
        button.elasticView.backgroundColor = .systemRed
        button.setTitle("P R E S S", for: .normal)
        return button
    }()
    //MARK: SUN
    lazy var sunView: UIImageView = {
        let currentView = UIImageView(image: UIImage(imageLiteralResourceName: "common_sun"))
        currentView.alpha = 0
        return currentView
    }()
    //MARK: HILL
    lazy var hillView: UIImageView = {
        let currentView = UIImageView(image: UIImage(imageLiteralResourceName: "common_hill"))
        currentView.alpha = 0
        currentView.isUserInteractionEnabled = false
        return currentView
    }()
    //MARK: CLOUD
    lazy var cloudView: UIImageView = {
        let currentView = UIImageView(image: UIImage(imageLiteralResourceName: "common_cloud"))
        currentView.backgroundColor = .clear
        return currentView
    }()
    //MARK: LIGHTNING
    lazy var lightningView: UIImageView = {
        let currentView = UIImageView(image: UIImage(imageLiteralResourceName: "common_lightning"))
        return currentView
    }()
    //because is unused
//    lazy var rainGifImage: UIImageView = {
//        let image = UIImage.animatedImageNamed("common_rain_gif", duration: 5)
//        let currentView = UIImageView(image: image)
//
//        return currentView
//    }()
    
//MARK: VIEW CONTROLLER LIFE CYCLE
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = dayBackgroundColor
        view.addSubview(titleLabel)
        view.addSubview(startButtonElastic)
        view.addSubview(cloudView)
        view.addSubview(sunView)
        view.addSubview(hillView)
    }
    //MARK: VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabelConstraints()
        startButtonConstraints()
        hillViewConstraints()
        cloudViewConstraints()
        sunViewConstraints()
        startButtonElastic.whenButtonIsTapped { [unowned self] in
            if animationState == .inProgress {
                startButtonElastic.isUserInteractionEnabled = false
            }
            switch dayState {
            case .day:
                self.nightIsComingAnimation()
            case .night:
                self.dayIsComingAnimation()
            }
            
        }
    }
    //MARK: VIEW DID APPEAR
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        introductionAnimation()
    }

//MARK: AUTOLAYOUT
    func titleLabelConstraints() {
        let guide = view.safeAreaLayoutGuide
        titleLabel.translatesAutoresizingMaskIntoConstraints                                                = false
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive                                   = true
        titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive                      = true
        titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive                     = true
        titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive             = true
    }
    
    func startButtonConstraints() {
        let guide = view.safeAreaLayoutGuide
        startButtonElastic.translatesAutoresizingMaskIntoConstraints                                        = false
        startButtonElastic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive     = true
        startButtonElastic.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive  = true
        startButtonElastic.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20).isActive     = true
        startButtonElastic.heightAnchor.constraint(equalToConstant: 70).isActive                            = true
    }
    
    func hillViewConstraints() {
        let hillViewHeight: CGFloat = 200
        hillView.translatesAutoresizingMaskIntoConstraints                                                  = false
        hillView.bottomAnchor.constraint(equalTo: startButtonElastic.topAnchor, constant: -20).isActive     = true
        hillView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                             = true
        hillView.heightAnchor.constraint(equalToConstant: hillViewHeight).isActive                          = true
        hillView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive                         = true
    }
    
    func cloudViewConstraints() {
        cloudView.translatesAutoresizingMaskIntoConstraints                                                 = false
        cloudView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive             = true
        //cloudView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                            = false
        cloudView.trailingAnchor.constraint(equalTo: view.leadingAnchor).isActive                           = true
        cloudView.widthAnchor.constraint(equalToConstant: 200).isActive                                     = true
        cloudView.heightAnchor.constraint(equalToConstant: 100).isActive                                    = true
    }
    
    func sunViewConstraints() {
        let sunViewHeight: CGFloat = 100
        let sunViewWidth: CGFloat = 100
        sunView.translatesAutoresizingMaskIntoConstraints                                                   = false
        sunView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                              = true
        sunView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive               = true
        sunView.heightAnchor.constraint(equalToConstant: sunViewHeight).isActive                            = true
        sunView.widthAnchor.constraint(equalToConstant: sunViewWidth).isActive                              = true
    }
    
//MARK: ANIMATIONS
    private func introductionAnimation() {
        UIView.animate(withDuration: 3,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        //introduction opacity UIView animation on titleLabel
                        self.titleLabel.alpha = 1
                        //introduction opacity UIView animation on hillView
                        self.hillView.alpha = 1
                        //introduction opacity UIView animation on sunView
                        self.sunView.alpha = 1
                        //introduction spring CAAnimation on hillView
                        let hillStartAnimation = CASpringAnimation(keyPath: "position.y")
                        hillStartAnimation.fromValue = self.titleLabel.frame.minY
                        hillStartAnimation.stiffness = 54
                        hillStartAnimation.damping = 3.7
                        hillStartAnimation.mass = 1
                        hillStartAnimation.initialVelocity = 0
                        hillStartAnimation.duration = hillStartAnimation.settlingDuration
                        self.hillView.layer.add(hillStartAnimation, forKey: "hillStartAnimation")
                        
                       })
    }
    
    @objc func nightIsComingAnimation() {
        //removing all animations from layers
        sunView.layer.removeAllAnimations()
        cloudView.layer.removeAllAnimations()
        hillView.layer.removeAllAnimations()
        //set animation state for controlling progress
        animationState = .inProgress
        //night is coming
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let sunOpacityAnimation = CABasicAnimation(keyPath: "opacity")
            let sunYPositionDownAnimation = CABasicAnimation(keyPath: "position.y")
            let cloudComingAnimation = CABasicAnimation(keyPath: "position.x")
            
            sunOpacityAnimation.fillMode = CAMediaTimingFillMode.forwards
            sunOpacityAnimation.fromValue = 1
            sunOpacityAnimation.toValue = 0
            sunOpacityAnimation.duration = 3
            sunOpacityAnimation.isRemovedOnCompletion = false
            sunOpacityAnimation.autoreverses = false

            sunYPositionDownAnimation.fillMode = CAMediaTimingFillMode.forwards
            sunYPositionDownAnimation.fromValue = self.sunView.frame.midY
            sunYPositionDownAnimation.toValue = self.hillView.frame.maxY - self.sunView.bounds.midY
            sunYPositionDownAnimation.duration = 3
            sunYPositionDownAnimation.isRemovedOnCompletion = false
            sunYPositionDownAnimation.autoreverses = false
            
            cloudComingAnimation.fillMode = CAMediaTimingFillMode.forwards
            cloudComingAnimation.toValue = self.view.frame.midX
            cloudComingAnimation.duration = 3
            cloudComingAnimation.isRemovedOnCompletion = false
            cloudComingAnimation.autoreverses = false
            
            self.sunView.layer.add(sunOpacityAnimation, forKey: "sunOpacityWhenGoingDown")
            self.sunView.layer.add(sunYPositionDownAnimation, forKey: "sunGoingDown")
            self.cloudView.layer.add(cloudComingAnimation, forKey: "cloudComing")
        }
        UIView.animate(withDuration: 2) {
            self.view.backgroundColor = self.nightBackgroundColor
            self.titleLabel.textColor = .systemYellow
        }
        dayState = .night
        animationState = .isEnded
    }
    
    @objc func dayIsComingAnimation() {
        animationState = .inProgress
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let sunOpacityAnimation = CABasicAnimation(keyPath: "opacity")
            let sunYPositionUpAnimation = CABasicAnimation(keyPath: "position.y")
            let cloudLeavingAnimation = CABasicAnimation(keyPath: "position.x")
            
            sunOpacityAnimation.fillMode = CAMediaTimingFillMode.forwards
            sunOpacityAnimation.fromValue = 0
            sunOpacityAnimation.toValue = 1
            sunOpacityAnimation.duration = 3
            sunOpacityAnimation.isRemovedOnCompletion = false
            sunOpacityAnimation.autoreverses = false

            sunYPositionUpAnimation.fillMode = CAMediaTimingFillMode.forwards
            sunYPositionUpAnimation.fromValue = self.hillView.frame.maxY - self.sunView.bounds.midY
            sunYPositionUpAnimation.toValue = self.sunView.frame.midY
            sunYPositionUpAnimation.duration = 3
            sunYPositionUpAnimation.isRemovedOnCompletion = false
            sunYPositionUpAnimation.autoreverses = false
            
            cloudLeavingAnimation.fillMode = CAMediaTimingFillMode.forwards
            cloudLeavingAnimation.toValue = self.view.frame.minX - self.cloudView.bounds.midX
            cloudLeavingAnimation.duration = 3
            cloudLeavingAnimation.isRemovedOnCompletion = false
            cloudLeavingAnimation.autoreverses = false
            
            self.sunView.layer.add(sunOpacityAnimation, forKey: "sunOpacityWhenUp")
            self.sunView.layer.add(sunYPositionUpAnimation, forKey: "sunUp")
            self.cloudView.layer.add(cloudLeavingAnimation, forKey: "cloudLeaving")
        }
        
        UIView.animate(withDuration: 2) {
            self.view.backgroundColor = self.dayBackgroundColor
            self.titleLabel.textColor = .white
        }
        
        dayState = .day
        animationState = .isEnded
    }
    
}

//states for animation for HomeWork13_Animations_ViewController
enum AnimationState {
    case none
    case inProgress
    case isEnded
}
//states for times of day for HomeWork13_Animations_ViewController
enum DayState {
    case day
    case night
}
