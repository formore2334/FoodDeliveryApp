//
//  CheckoutListCell.swift
//  OrderApp
//
//  Created by ForMore on 16/11/2023.
//

import UIKit

class CheckoutListCell: UITableViewCell {
    
    static let identifier = "CheckoutListCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    
     var textField: UITextField = {
        let textField = UITextField()

        return textField
    }()
    
    var didEnterText: ((String) -> ())?
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with checkoutListInfo: CheckoutListInfo) {
        titleLabel.text = checkoutListInfo.rawValue
    }
    
    private func configureContentView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        textField.delegate = self
        
        setConstraints()
    }
    
    //MARK: - Constraints
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

extension CheckoutListCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEnterText?(textField.text ?? "")
    }
}
