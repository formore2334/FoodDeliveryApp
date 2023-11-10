//
//  SaleCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class SaleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SaleCollectionViewCell"
    
    private var cellContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 15
        container.layer.borderWidth = 3
        container.layer.borderColor = UIColor.purple.cgColor
        container.layer.opacity = 0.2
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
            
            imageView.centerXAnchor.constraint(equalTo: cellContainer.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: cellContainer.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: cellContainer.heightAnchor, multiplier: 0.8),
            imageView.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.9),
            
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
}
