//
//  CouponCell.swift
//  OrderApp
//
//  Created by ForMore on 22/11/2023.
//

import UIKit


final class CouponCollectionViewCell: UICollectionViewCell {
    
    let networkManager = NetworkManager()
    
    private lazy var cellContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 15
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor(patternImage: UIImage(named: "redWhiteDottedLine")!).cgColor
        container.layer.opacity = 0.8
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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        contentView.addSubview(cellContainer)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        setConstraints()
    }
    
    // MARK: - Configurations
    
    func configure(stringURL: String, title: String) {
        titleLabel.text = title
        
        // Config imageView
        getImage(stringURL: stringURL)
    }
    
    // Receives image with url
    private func getImage(stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        // Calls a completion handler to get image
        networkManager.fetchImage(url: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        
    }
    
}

//MARK: - Constraints

private extension CouponCollectionViewCell {
    
    func setConstraints() {
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
            imageView.heightAnchor.constraint(equalTo: cellContainer.heightAnchor, multiplier: 0.75),
            imageView.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.9),
            
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
