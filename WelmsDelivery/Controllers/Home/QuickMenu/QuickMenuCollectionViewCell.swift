//
//  CircleCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

final class QuickMenuCollectionViewCell: UICollectionViewCell {
    
    private lazy var cellContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemGray5
        container.layer.cornerRadius = 10
        return container
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        return title
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setup() {
        contentView.addSubview(cellContainer)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        setShadow()
        setConstraints()
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    //MARK: - Configurations
    
    func configure(imageName: String, title: String) {
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
    }
    
}

//MARK: - Constraints

private extension QuickMenuCollectionViewCell {
    
    func setConstraints() {
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
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -10)
        ])
    }
    
}
