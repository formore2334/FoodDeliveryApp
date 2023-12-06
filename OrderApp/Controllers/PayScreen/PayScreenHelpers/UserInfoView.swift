//
//  UserInfoView.swift
//  OrderApp
//
//  Created by ForMore on 04/12/2023.
//

import UIKit


class UserInfoView: UIView {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 26, y: 0, width: bounds.width, height: 20)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 26, y: 0, width: bounds.width, height: 20)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 26, y: 0, width: bounds.width, height: 20)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 26, y: 0, width: bounds.width, height: 20)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func setup() {
        addSubview(stackView)
 
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(phoneNumberLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(addressLabel)
        
        setConstraints()
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

// Text style like bill info
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
