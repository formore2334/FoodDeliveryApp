//
//  DetailMenuCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 17/10/2023.
//

import UIKit

class DetailMenuCollectionViewCell: UICollectionViewCell {
    
    private let networkManager = NetworkManager()
    
    private var cellContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemGray5
        container.layer.cornerRadius = 10
        container.layer.cornerRadius = 100.0 / 2.0
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.opacity = 0.5
        return container
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 90.0 / 2.0
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
        
       setDetailMenuConstraints()
    }
    
    public func configure(stringURL: String, title: String) {
        titleLabel.text = title
        
        getImage(stringURL: stringURL)
    }
    
    private func getImage(stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        networkManager.fetchImage(url: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    //MARK: - Constraints
    
    private func setDetailMenuConstraints() {
        cellContainer.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: cellContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: cellContainer.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: cellContainer.heightAnchor, multiplier: 0.9),
            imageView.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.9),
            
            titleLabel.topAnchor.constraint(equalTo: cellContainer.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: cellContainer.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
