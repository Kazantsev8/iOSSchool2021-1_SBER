//
//  ShareActivity.swift
//  11thLessionHomeTask
//
//  Created by Иван Казанцев on 19.05.2021.
//

import UIKit

class CustomActivity: UIActivity {

    override class var activityCategory: UIActivity.Category { .share }
    override var activityType: UIActivity.ActivityType? { .none }
    
    override var activityTitle: String? {
        "Activity"
    }
    
    override var activityImage: UIImage? {
        UIImage(systemName: "square.and.arrow.up")
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        true
    }
    
}
