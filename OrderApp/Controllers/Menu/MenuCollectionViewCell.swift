//
//  MenuCell.swift
//  OrderApp
//
//  Created by ForMore on 13/11/2023.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    private let networkManager = NetworkManager()
    
    private let starView = StarView()
    
    // MARK: - Set variables
    
    private lazy var cellContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemGray5
        container.layer.cornerRadius = 10
        container.layer.cornerRadius = 100.0 / 2.0
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.opacity = 0.5
        return container
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 90.0 / 2.0
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 15)
        return title
    }()
    
    private lazy var priceLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.preferredFont(forTextStyle: .subheadline)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        starView.layer.removeAllAnimations()
    }
    
    // MARK: - Setup
    
    private func setup() {
        contentView.addSubview(cellContainer)
        contentView.addSubview(imageView)
        contentView.addSubview(starView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        setDetailMenuConstraints()
    }
    
    // MARK: - Configurations
    
    func configure(menuItem: (any MenuItemProtocol)) {
        
        if let discountMenuItem = menuItem as? DiscountMenuItem {
            
            // New price string
            let priceString = "\(discountMenuItem.newPrice)$"
            
            // Makes string strike out
            let oldPriceString = " \(menuItem.price)"
            let attributedString = NSAttributedString()
            let crossedPriceString = attributedString.concatenationWithCrossOut(baseString: priceString,
                                                                                crossedString: oldPriceString,
                                                                                crossedStringFontSize: 11)
            
            // Config label with crossed price string
            priceLabel.attributedText = crossedPriceString
        } else {
            
            // Config label only with old price
            priceLabel.text = "\(menuItem.price)$"
        }
        
        // Sets starView only for SpecialMenuItem's
        if menuItem as? SpecialMenuItem != nil {
            starView.isHidden = false
        } else {
            starView.isHidden = true
        }
        
        starView.startPulseAnimation()
        titleLabel.text = menuItem.title
        
        // Config imageView
        getImage(stringURL: menuItem.imageURL)
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

private extension MenuCollectionViewCell {
    
    func setDetailMenuConstraints() {
        cellContainer.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        starView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: cellContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: cellContainer.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: cellContainer.heightAnchor, multiplier: 0.9),
            imageView.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.9),
            
            starView.topAnchor.constraint(equalTo: cellContainer.topAnchor, constant: -4),
            starView.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: 10),
            starView.heightAnchor.constraint(equalToConstant: 25),
            starView.widthAnchor.constraint(equalToConstant: 25),
            
            titleLabel.topAnchor.constraint(equalTo: cellContainer.bottomAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: cellContainer.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
}
