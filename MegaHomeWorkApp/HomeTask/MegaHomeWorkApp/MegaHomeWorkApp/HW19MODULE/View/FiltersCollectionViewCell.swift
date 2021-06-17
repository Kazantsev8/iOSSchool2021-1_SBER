//
//  FiltersCollectionViewCell.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 09.06.2021.
//

import UIKit

class FiltersCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "filtersCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func imageViewLayout() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
}
