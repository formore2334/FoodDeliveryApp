//
//  CircleCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class PopularCategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCategoriesCollectionViewCell"
    
    private var cellContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .lightGray
        container.layer.cornerRadius = 10
        return container
    }()

    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        return title
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)

        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.addSubview(cellContainer)
         contentView.addSubview(imageView)
         contentView.addSubview(titleLabel)
        
        setConstraints()
     }
     
     public func configure(imageName: String, title: String) {
         imageView.image = UIImage(named: imageName)
         titleLabel.text = title
         
     }
     
     //MARK: - Constraints
     
    private func setConstraints() {
        cellContainer.translatesAutoresizingMaskIntoConstraints = false
         imageView.translatesAutoresizingMaskIntoConstraints = false
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                imageView.centerYAnchor.constraint(equalTo: cellContainer.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor, constant: 10),
                imageView.heightAnchor.constraint(equalTo: cellContainer.heightAnchor, multiplier: 0.7),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
                
                titleLabel.centerYAnchor.constraint(equalTo: cellContainer.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -10)
            ])

     }
    
}
