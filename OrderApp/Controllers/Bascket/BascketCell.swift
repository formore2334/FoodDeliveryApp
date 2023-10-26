//
//  BascketCell.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit

class BascketCell: UITableViewCell {

    static let identifier = String(describing: BascketCell.self)
    
    //MARK: - Set varibles
    
    private var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 70.0 / 2.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
    
    private var numberOfItemsLabel: UILabel = {
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
    
    public func configureCell(menuItem: MenuItem) {
        itemImageView.image = UIImage(named: menuItem.imageName)
        itemTextLabel.text = menuItem.title
        //numberOfItemsLabel.text = "\(numberOfItems)"
    }
    
    private func configureContentView() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemTextLabel)
        contentView.addSubview(subtractItemButton)
        contentView.addSubview(numberOfItemsLabel)
        contentView.addSubview(addItemButton)
        setAllConstraints()
    }
    
    private func configureAddItemButton() {
        
    }
    
    private func subtractAddItemButton() {
        
    }
    
    //MARK: - Constraints
    
    
    /// Set All constraints together
    private func setAllConstraints() {
        setItemImageViewConstraints()
        setItemTextLabelConstraints()
        setSubtractItemButtonConstraints()
        setNumberOfItemsLabelConstraints()
        setAddItemButtonConstraints()
    }
    
    /// Set constraints to each varible
    private func setItemImageViewConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: 70),
            itemImageView.widthAnchor.constraint(equalToConstant: 70),
            
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
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
            subtractItemButton.trailingAnchor.constraint(equalTo: numberOfItemsLabel.leadingAnchor, constant: -5)
        ])
    }
    
    private func setNumberOfItemsLabelConstraints() {
        numberOfItemsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberOfItemsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberOfItemsLabel.trailingAnchor.constraint(equalTo: addItemButton.leadingAnchor, constant: -5)
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
