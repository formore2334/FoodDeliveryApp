//
//  DetailMenuCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 17/10/2023.
//

import UIKit

class DetailMenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailMenuCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100.0 / 2.0
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(named: "redOrange")?.cgColor
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        return title
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)

        configureDetailMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
    }
    
    //MARK: - Configure DetailMenuView
    
    func configureDetailMenu() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
       setDetailMenuConstraints()
    }
    
    public func configure(name: String, title: String) {
        imageView.image = UIImage(named: name)
        titleLabel.text = title
    }
    
    //MARK: - Constraints
    
    func setDetailMenuConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
