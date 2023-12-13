//
//  DetailMenuCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 17/10/2023.
//

import UIKit

class DetailMenuCollectionViewCell: UICollectionViewCell {
    
    private let networkManager = NetworkManager()
    
    private let starView = StarView()
    
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
    
    override init(frame: CGRect) {
        super .init(frame: frame)

        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        starView.layer.removeAllAnimations()
    }

    private func configureCell() {
        contentView.addSubview(cellContainer)
        contentView.addSubview(imageView)
        contentView.addSubview(starView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
       setDetailMenuConstraints()
    }
    
    public func configure(menuItem: MenuItem) {
        
        if let discountMenuItem = menuItem as? DiscountMenuItem {
            let priceString = "\(discountMenuItem.newPrice)$"
            let crossedOldPriceString = " \(menuItem.price)"
            
            let attributedString = NSAttributedString()
            let prepareAttributedString = attributedString.concatenationWithCrossOut(baseString: priceString, crossedString: crossedOldPriceString, crossedStringFontSize: 11)
            
            priceLabel.attributedText = prepareAttributedString
        } else {
            priceLabel.text = "\(menuItem.price)$"
        }
        
        if menuItem as? SpecialSaleMenuItem != nil {
            starView.isHidden = false
        } else {
            starView.isHidden = true
        }
        
        titleLabel.text = menuItem.title
        getImage(stringURL: menuItem.imageURL)
        
        starView.startPulseAnimation()
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
        starView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
