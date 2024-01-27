//
//  SpecialItemView.swift
//  OrderApp
//
//  Created by ForMore on 20/01/2024.
//

import UIKit

class SpecialItemView: UIView {
    
    private let networkManager = NetworkManager()
    
    //MARK: - Set varibles
    
    private var container = UIView()
    
    // Holder with fixed height of 50 points for dynamic autoresizing cell's in table
    private var heightHolder: UILabel = {
        var label = UILabel()
        label.text = "1" // Jast for hold height
        label.font = .systemFont(ofSize: 50)
        label.alpha = 0.0
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()

    private var crossPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40.0 / 2.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()

    private var itemTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    private var itemCountsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .red
        label.alpha = 0.65
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        addSubview(container)
        
        container.addSubview(heightHolder)
        container.addSubview(itemImageView)
        container.addSubview(itemTextLabel)
        container.addSubview(itemCountsLabel)
        container.addSubview(priceLabel)
        container.addSubview(crossPriceLabel)
        
        setAllConstraints()
    }
    
    //MARK: - Configurations
    
    func configure(specialItem: SpecialMenuItem, itemCounts: Int) {
        
        // Makes string strike out
        let crossedString = "\(specialItem.price)"
        let crossedPrice = crossedString.crossOutTheLine()
        
        // Config label with crossed string
        crossPriceLabel.attributedText = crossedPrice
        priceLabel.text = "\(specialItem.newPrice)$"
        
        itemTextLabel.text = specialItem.title
        
        itemCountsLabel.text = "x" + "\(itemCounts)"
        
        // Config imageView
        getImage(stringURL: specialItem.imageURL)
    }
    
    // Receives image with url
    private func getImage(stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        // Calls a completion handler to get image
        networkManager.fetchImage(url: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.itemImageView.image = image
            }
        }
        
    }

}

//MARK: - Constraints

private extension SpecialItemView {

    // Set All constraints together
    func setAllConstraints() {
        setContainerConstraints()
        setHeightHolderConstraints()
        setItemTextLabelConstraints()
        setItemImageViewConstraints()
        setItemCountsLabelConstraints()
        setPriceLabelConstraints()
        setCrossPriceLabelConstraints()
    }
    
    // Set constraints to each varible
    
    func setContainerConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func setHeightHolderConstraints() {
        heightHolder.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heightHolder.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            heightHolder.topAnchor.constraint(equalTo: container.topAnchor),
            heightHolder.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            heightHolder.widthAnchor.constraint(equalToConstant: 10)
        ])
    }

    func setItemImageViewConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            itemImageView.heightAnchor.constraint(equalToConstant: 40),
            itemImageView.widthAnchor.constraint(equalToConstant: 40),
            itemImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
    }

    func setItemTextLabelConstraints() {
        itemTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            itemTextLabel.heightAnchor.constraint(equalToConstant: 40),
            itemTextLabel.widthAnchor.constraint(equalToConstant: 75),

            itemTextLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            itemTextLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }

    func setItemCountsLabelConstraints() {
        itemCountsLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemCountsLabel.leadingAnchor.constraint(equalTo: itemTextLabel.trailingAnchor, constant: 15),
            itemCountsLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
    
    func setPriceLabelConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: itemCountsLabel.trailingAnchor, constant: 30),
            priceLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
    }
    
    func setCrossPriceLabelConstraints() {
        crossPriceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            crossPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.centerYAnchor, constant: -10),
            crossPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.centerXAnchor, constant: 5)
        ])
    }
    
}
