//
//  CheckoutListCell.swift
//  OrderApp
//
//  Created by ForMore on 16/11/2023.
//

import UIKit

class CheckoutListCell: UITableViewCell {
    
    private var textField = UITextField()
    
    var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .red
        label.text = ""
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
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
    
    public func configure(with checkoutListItem: CheckoutList) {
        textField.placeholder = checkoutListItem.rawValue
    }
    
    private func configureContentView() {
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(textField)
        contentStackView.addArrangedSubview(errorLabel)
        
        textField.delegate = self
        
        setConstraints()
    }
    
    //MARK: - Constraints
    
    func setConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

// MARK: - Text Delegate
extension CheckoutListCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEnterText?(textField.text ?? "")
    }
}
