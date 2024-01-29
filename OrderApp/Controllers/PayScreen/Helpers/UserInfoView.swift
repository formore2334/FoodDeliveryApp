//
//  UserInfoView.swift
//  OrderApp
//
//  Created by ForMore on 04/12/2023.
//

import UIKit


final class UserInfoView: UIView {
    
    // MARK: - Set variables
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 26, y: 0, width: bounds.width, height: 20)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 26, y: 0, width: bounds.width, height: 20)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 26, y: 0, width: bounds.width, height: 20)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 26, y: 0, width: bounds.width, height: 20)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        addSubview(stackView)
        
        // Constraints
        stackView.pinToBounds(to: self)
 
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(phoneNumberLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(addressLabel)
    }
    
    //MARK: - Configurations
    
    func configure(with userInfo: UserInfo, isBillTextStyle: Bool = false) {
        
        if isBillTextStyle {
            billStyleTextFormat(userInfo: userInfo)
        } else {
            nameLabel.text = userInfo.name
            phoneNumberLabel.text = userInfo.phone
            emailLabel.text = userInfo.email
            addressLabel.text = userInfo.address
        }
        
    }
    
}

// Makes text style like bill info
extension UserInfoView {
    
    func billStyleTextFormat(userInfo: UserInfo) {
        nameLabel.text = "Name:" + " " + userInfo.name
        phoneNumberLabel.text = "Phone Number:" + " " + userInfo.phone
        emailLabel.text = "Email:" + " " + userInfo.email
        addressLabel.text = "Address:" + " " + userInfo.address
        
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        
        phoneNumberLabel.textColor = .black
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 13)
        
        emailLabel.textColor = .black
        emailLabel.font = UIFont.systemFont(ofSize: 13)
        
        addressLabel.textColor = .black
        addressLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
}
