//
//  BasketSpecialCell.swift
//  OrderApp
//
//  Created by ForMore on 27/12/2023.
//

import UIKit

protocol SpecialCellDelegate: AnyObject {
    func deleteButtonDidTapped(_ cell: UITableViewCell)
}

final class SpecialTableViewCell: UITableViewCell {
    
    weak var delegate: SpecialCellDelegate?
    
    // MARK: - Set varibles
    
    // Container to hold only color
    private let colorContainer = UIView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private var totalCrossPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    var cellNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
        configureDeleteButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Cleanses cell from stackView subviews to correct reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    // MARK: - Setup
    
    private func setup() {
        contentView.addSubview(colorContainer)
        
        contentView.addSubview(stackView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        contentView.addSubview(totalPriceLabel)
        contentView.addSubview(cellNumberLabel)
        
        // Sets color container appearance
        colorContainer.backgroundColor = UIColor(named: "lightYellowTranslucent")
        
        setConstraints()
    }
    
    //MARK: - Configurations
    
    func configure(basketSpecialItem: BasketSpecialItem, cellNumber: Int) {
        
        // Creates view for each special menuItem, configure it and adds to stackView
        basketSpecialItem.specialMenuItems.forEach { specialItem in
            let specialItemView = SpecialItemView()
            specialItemView.configure(specialItem: specialItem.menuItem, itemCounts: specialItem.count)
            
            stackView.addArrangedSubview(specialItemView)
        }
        
        titleLabel.text = basketSpecialItem.discountTitle
        totalPriceLabel.text = "\(basketSpecialItem.totalSum)" + "$"
        
        cellNumberLabel.text = "\(cellNumber)" + "."
    }

}

//MARK: - Delete button logic

private extension SpecialTableViewCell {
    
    func configureDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonDidTapped() {
        
        delegate?.deleteButtonDidTapped(self)
    }
    
}

// MARK: - Constraints

private extension SpecialTableViewCell {
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        cellNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        colorContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Here layoutMarginsGuide used for correct positioning and autoresizing
        // Each specialItemView inside cell
        let g = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            
            // Sets constraints without paddings to completely cover the cell with color
            colorContainer.topAnchor.constraint(equalTo: topAnchor),
            colorContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            colorContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Constrain label Top, Leading to contentView margins
            titleLabel.topAnchor.constraint(equalTo: g.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 40),
            
            // Constrain stackView Leading, Bottom to contentView margins
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0),
            stackView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 40.0),
            stackView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0.0),
            stackView.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: 0),
            
            // Constrain label Top, Leading to contentView margins
            totalPriceLabel.topAnchor.constraint(equalTo: g.topAnchor),
            totalPriceLabel.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 245),
            
            cellNumberLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -30),
            cellNumberLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            // Constrain button Trailing, CenterY to contentView margins
            deleteButton.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -10.0),
            deleteButton.centerYAnchor.constraint(equalTo: g.centerYAnchor, constant: 0.0),

            deleteButton.widthAnchor.constraint(equalToConstant: 24.0),
            deleteButton.heightAnchor.constraint(equalTo: deleteButton.widthAnchor),
        ])
    }
    
}
