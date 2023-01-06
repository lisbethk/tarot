import UIKit

final class SpreadCell: UICollectionViewCell {
    static let identifier = "spread"
    
    private let image: UIImageView = {
        let cards = UIImageView()
        cards.contentMode = .scaleAspectFill
        cards.clipsToBounds = true
        return cards
    }()
    
    private let descriptionLabel: UILabel = {
        let questions = UILabel()
        questions.lineBreakMode = .byWordWrapping
        questions.numberOfLines = 0
        questions.font = .yarin(ofSize: 20)
        return questions
    }()
    
    private let titleLabel: UILabel = {
        let name = UILabel()
        name.font = .yarin(ofSize: 30)
        return name
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        contentView.addSubview(image)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(60)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        descriptionLabel.text = nil
        titleLabel.text = nil
    }
    
    struct Model {
        let image: UIImage
        let description: String
        let title: String
    }
    
    func configure(with model: Model) {
        image.image = model.image
        descriptionLabel.text = model.description
        titleLabel.text = model.title
    }
}
