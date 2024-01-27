//
//  BasketRegularCell.swift
//  OrderApp
//
//  Created by ForMore on 28/12/2023.
//

import UIKit

protocol RegularCellDelegate: AnyObject {
    func didTapAddButton(_ cell: UITableViewCell)
    func didTapSubtractButton(_ cell: UITableViewCell)
}

class RegularTableViewCell: UITableViewCell {
    
    private let networkManager = NetworkManager()
    
    weak var delegate: RegularCellDelegate?
    
    //MARK: - Set varibles
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
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
        imageView.layer.cornerRadius = 70.0 / 2.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private var itemTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var subtractItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private var itemsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(0)"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.alpha = 0.65
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var addItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        contentView.addSubview(priceLabel)
        contentView.addSubview(crossPriceLabel)
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemTextLabel)
        contentView.addSubview(subtractItemButton)
        contentView.addSubview(itemsCountLabel)
        contentView.addSubview(addItemButton)
        
        setAllConstraints()
        configureAddItemButton()
        configureSubtractItemButton()
    }
    
   //MARK: - Configurations
    
    public func configure(menuItem: (any MenuItemProtocol), itemsCount: Int, totalPrice: (Double, Double)) {
        
        if menuItem as? DiscountMenuItem != nil {
            
            // Makes string strike out
            let crossedString = "\(totalPrice.1)"
            let crossedPrice = crossedString.crossOutTheLine()
            
            // Config label with old price crossed string
            crossPriceLabel.attributedText = crossedPrice
            
            // Config label with old price
            priceLabel.text = "\(totalPrice.0)$"
        } else {
            
            // Config label only with old price
            crossPriceLabel.text = ""
            priceLabel.text = "\(totalPrice.0)$"
        }
        
        
        itemTextLabel.text = menuItem.title
        itemsCountLabel.text = "\(itemsCount)"
        
        // Config imageView
        getImage(stringURL: menuItem.imageURL)
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

// MARK: - Add & Subtract buttons logic

extension RegularTableViewCell {
    
    // Calls delegate for adding menuItem
    private func configureAddItemButton() {
        addItemButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        
        delegate?.didTapAddButton(self)
    }

    // Calls delegate for subtracting menuItem
    private func configureSubtractItemButton() {
        subtractItemButton.addTarget(self, action: #selector(subtractButtonTapped), for: .touchUpInside)
    }
    
    @objc private func subtractButtonTapped() {
        
        delegate?.didTapSubtractButton(self)
    }
    
}

//MARK: - Constraints

private extension RegularTableViewCell {
    
    // Set All constraints together
    func setAllConstraints() {
        setPriceLabelConstraints()
        setCrossPriceLabelConstraints()
        setItemImageViewConstraints()
        setItemTextLabelConstraints()
        setSubtractItemButtonConstraints()
        setItemCountsLabelConstraints()
        setAddItemButtonConstraints()
    }
    
    // Set constraints to each varible
    func setPriceLabelConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            priceLabel.widthAnchor.constraint(equalToConstant: 50),
            
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    func setCrossPriceLabelConstraints() {
        crossPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            crossPriceLabel.heightAnchor.constraint(equalToConstant: 20),
            crossPriceLabel.widthAnchor.constraint(equalToConstant: 30),
            
            crossPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.centerYAnchor, constant: -10),
            crossPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.centerXAnchor)
        ])
    }
    
    func setItemImageViewConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: 70),
            itemImageView.widthAnchor.constraint(equalToConstant: 70),
            
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10)
        ])
    }
    
    func setItemTextLabelConstraints() {
        itemTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemTextLabel.heightAnchor.constraint(equalToConstant: 70),
            itemTextLabel.widthAnchor.constraint(equalToConstant: 100),
            
            itemTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemTextLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10)
        ])
    }
    
    func setSubtractItemButtonConstraints() {
        subtractItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtractItemButton.heightAnchor.constraint(equalToConstant: 20),
            subtractItemButton.widthAnchor.constraint(equalToConstant: 20),
            
            subtractItemButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subtractItemButton.trailingAnchor.constraint(equalTo: itemsCountLabel.leadingAnchor, constant: -5)
        ])
    }
    
    func setItemCountsLabelConstraints() {
        itemsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemsCountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemsCountLabel.trailingAnchor.constraint(equalTo: addItemButton.leadingAnchor, constant: -5)
        ])
    }
    
    func setAddItemButtonConstraints() {
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addItemButton.heightAnchor.constraint(equalToConstant: 20),
            addItemButton.widthAnchor.constraint(equalToConstant: 20),
            
            addItemButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addItemButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
}
