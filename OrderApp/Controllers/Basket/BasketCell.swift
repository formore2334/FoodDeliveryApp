//
//  BascketCell.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit

protocol BasketCellDelegate: AnyObject {
   
    func didTapAddButton(_ cell: UITableViewCell)
    
    func didTapSubtractButton(_ cell: UITableViewCell)

}

class BasketCell: UITableViewCell {
    
    var menuItem: MenuItem?
    
    weak var delegate: BasketCellDelegate?
    
    static let identifier = String(describing: BasketCell.self)
    
    //MARK: - Set varibles
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
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
    
    private var itemCountsLabel: UILabel = {
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
        
        configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   //MARK: - Configurations
    
    public func configureCell(menuItem: MenuItem, itemCounts: Int) {
        priceLabel.text = "\(menuItem.price)$"
        itemImageView.image = UIImage(named: menuItem.imageName)
        itemTextLabel.text = menuItem.title
        itemCountsLabel.text = "\(itemCounts)"
    }
    
    private func configureContentView() {
        contentView.addSubview(priceLabel)
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemTextLabel)
        contentView.addSubview(subtractItemButton)
        contentView.addSubview(itemCountsLabel)
        contentView.addSubview(addItemButton)
        setAllConstraints()
        configureAddItemButton()
        configureSubtractItemButton()
    }
    
    private func configureAddItemButton() {
        addItemButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        guard let itemCountsText = itemCountsLabel.text,
              let itemCounts = Int(itemCountsText) else {
            return
        }
        
        itemCountsLabel.text = "\(itemCounts + 1)"
        
        delegate?.didTapAddButton(self)
    }

    
    private func configureSubtractItemButton() {
        subtractItemButton.addTarget(self, action: #selector(subtractButtonTapped), for: .touchUpInside)
    }
    
    @objc private func subtractButtonTapped() {
        guard let itemCountsText = itemCountsLabel.text,
              let itemCounts = Int(itemCountsText),
              itemCounts > 0
        else {
            return
        }
        
        itemCountsLabel.text = "\(itemCounts - 1)"
        
        delegate?.didTapSubtractButton(self)
    }
    
    //MARK: - Constraints
    
    
    /// Set All constraints together
    private func setAllConstraints() {
        setPriceLabelConstraints()
        setItemImageViewConstraints()
        setItemTextLabelConstraints()
        setSubtractItemButtonConstraints()
        setItemCountsLabelConstraints()
        setAddItemButtonConstraints()
    }
    
    /// Set constraints to each varible
    private func setPriceLabelConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            priceLabel.widthAnchor.constraint(equalToConstant: 50),
            
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    private func setItemImageViewConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: 70),
            itemImageView.widthAnchor.constraint(equalToConstant: 70),
            
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10)
        ])
    }
    
    private func setItemTextLabelConstraints() {
        itemTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemTextLabel.heightAnchor.constraint(equalToConstant: 70),
            itemTextLabel.widthAnchor.constraint(equalToConstant: 100),
            
            itemTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemTextLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10)
        ])
    }
    
    private func setSubtractItemButtonConstraints() {
        subtractItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtractItemButton.heightAnchor.constraint(equalToConstant: 20),
            subtractItemButton.widthAnchor.constraint(equalToConstant: 20),
            
            subtractItemButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subtractItemButton.trailingAnchor.constraint(equalTo: itemCountsLabel.leadingAnchor, constant: -5)
        ])
    }
    
    private func setItemCountsLabelConstraints() {
        itemCountsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemCountsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemCountsLabel.trailingAnchor.constraint(equalTo: addItemButton.leadingAnchor, constant: -5)
        ])
    }
    
    private func setAddItemButtonConstraints() {
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addItemButton.heightAnchor.constraint(equalToConstant: 20),
            addItemButton.widthAnchor.constraint(equalToConstant: 20),
            
            addItemButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addItemButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
}