//  theMajorArcana.swift
//  tarot

import UIKit

final class CardCell: UICollectionViewCell {
    static let identifier = "theMajorArcana"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    struct Model {
        let image: UIImage
    }
    
    func configure(with model: Model) {
        imageView.image = model.image
    }
}
