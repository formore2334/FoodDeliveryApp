//
//  CheckoutListCell.swift
//  OrderApp
//
//  Created by ForMore on 16/11/2023.
//

import UIKit

final class CheckoutListTableViewCell: UITableViewCell {
    
    private var textField = UITextField()
    
    // Configurates from master vc
    weak var errorLabel: UILabel? = {
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
        
        if let errorLabel = errorLabel {
            stackView.addArrangedSubview(errorLabel)
        }
        
        textField.delegate = self
    }
    
    // MARK: - Configurations
    
    func configure(with checkoutListItem: CheckoutList) {
        textField.placeholder = checkoutListItem.rawValue
    }
    
}

// MARK: - Text Delegate

extension CheckoutListTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEnterText?(textField.text ?? "")
    }
}
