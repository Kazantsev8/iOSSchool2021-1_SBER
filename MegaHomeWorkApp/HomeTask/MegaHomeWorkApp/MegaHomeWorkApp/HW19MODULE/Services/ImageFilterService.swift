//
//  ImageFilterService.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 16.06.2021.
//

import UIKit

struct Filters {
    
    static let values: [CIFilter?] = [
        CIFilter(name: "CIPhotoEffectChrome"),
        CIFilter(name: "CIPhotoEffectFade"),
        CIFilter(name: "CIPhotoEffectInstant"),
        CIFilter(name: "CIPhotoEffectMono"),
        CIFilter(name: "CIPhotoEffectNoir"),
        CIFilter(name: "CIPhotoEffectProcess"),
        CIFilter(name: "CIPhotoEffectTonal"),
        CIFilter(name: "CIPhotoEffectTransfer"),
        CIFilter(name: "CISepiaTone")
    ]
    
}

class ImageFilterService: ImageFilterServiceProtocol {
    
    var context = CIContext()
    var filters: [CIFilter?] = Filters.values
    
    func change(image: UIImage?, with filter: CIFilter?, handler: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            guard let image = image else { DispatchQueue.main.async { handler(nil) } ; return }
            guard let filter = filter else { DispatchQueue.main.async { handler(nil)} ; return }
            let ciImage = CIImage(image: image)
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            guard let fltrdImage = filter.outputImage else { DispatchQueue.main.async { handler(nil) } ; return }
            guard let cgImage = self.context.createCGImage(fltrdImage, from: fltrdImage.extent) else {
                DispatchQueue.main.async { handler(nil) } ; return
            }
            let imageToReturn = UIImage(cgImage: cgImage)
            DispatchQueue.main.async { handler(imageToReturn) }
        }
    }
    
}

