//
//  CheckoutListCell.swift
//  OrderApp
//
//  Created by ForMore on 16/11/2023.
//

import UIKit

final class CheckoutListTableViewCell: UITableViewCell {
    
    private let textField = UITextField()
    
    // Configurates from master vc
     private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .red
        label.text = ""
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    var didEnterText: ((String) -> ())?
    
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
        contentView.addSubview(stackView)
        
        // Constraints
        stackView.pinToBounds(to: contentView)
        
        stackView.addArrangedSubview(textField)
        
        stackView.addArrangedSubview(errorLabel)
        
        textField.delegate = self
    }
    
    // MARK: - Configurations
    
    func configure(with checkoutListItem: CheckoutList) {
        textField.placeholder = checkoutListItem.rawValue
    }
    
    func configureErrorLabel(_ errorText: String) {
        errorLabel.text = errorText
    }
    
}

// MARK: - Text Delegate

extension CheckoutListTableViewCell: UITextFieldDelegate {
    
    // Handle each character in textField immediately
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            didEnterText?(text)
        }
        return true
    }
    
    // Hide keyboard when user press return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.textField.resignFirstResponder()
    }

    
}
