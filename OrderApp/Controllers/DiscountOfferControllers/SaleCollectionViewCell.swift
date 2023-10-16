//
//  SaleCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class SaleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SaleCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 130.0 / 2.0
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemPink.cgColor
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        return title
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        titleLabel.frame = CGRect(x: 0, y: imageView.frame.maxY + 10, width: contentView.bounds.width, height: 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    public func configure(name: String, title: String) {
        imageView.image = UIImage(named: name)
        titleLabel.text = title
    }
}
