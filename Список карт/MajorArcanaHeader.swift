//  MajorArcanaHeader.swift
//  tarot

import UIKit
import SnapKit

final class MajorArcanaHeader: UICollectionReusableView {
    
    static let reuseId = "MajorArcanaHeader"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        label.font = UIFont(name: "Yarin", size: 38)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Model {
        let text: String
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.text
    }
}
