//
//  ImageFilterServiceProtocol.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 16.06.2021.
//

import UIKit

protocol HasImageFilterServiceProtocol {
    
    var imageFilterService: ImageFilterServiceProtocol { get }
    
}

protocol ImageFilterServiceProtocol {
    
    var filters: [CIFilter?] { get }
    func change(image: UIImage?, with filter: CIFilter?, handler: @escaping (UIImage?) -> ())
    
}
