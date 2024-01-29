//
//  CheckDetailsView.swift
//  OrderApp
//
//  Created by ForMore on 04/12/2023.
//

import UIKit


protocol ConformButtonDelegate: AnyObject {
    func didTapButton()
}

final class UserDetailsView: UIView {
    
    private var userInfoView = UserInfoView()
    
    private var container = UIView()
    
    weak var delegate: ConformButtonDelegate?
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Check your details"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    private lazy var conformButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 25)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 7
        button.backgroundColor = .systemBlue
        button.setTitle("Conform", for: .normal)
        return button
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
        addSubview(container)
        
        container.addSubview(headerLabel)
        container.addSubview(conformButton)
        container.addSubview(userInfoView)
        
        conformButtonAction()
        
        setConstraints()
    }
    
    //MARK: - Configurations
    
    func configure(with userInfo: UserInfo) {
        userInfoView.configure(with: userInfo)
    }
    
    // Adding action
    private func conformButtonAction() {
        conformButton.addTarget(self, action: #selector(conformButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func conformButtonDidTapped() {
        delegate?.didTapButton()
        conformButton.scaleAnimation()
    }
    
}

//MARK: - Constraints

private extension UserDetailsView {
    
    func setConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        conformButton.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 15),
            
            conformButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            conformButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            conformButton.heightAnchor.constraint(equalToConstant: 25),
            conformButton.widthAnchor.constraint(equalToConstant: 70),
            
            userInfoView.topAnchor.constraint(equalTo: conformButton.bottomAnchor, constant: 10),
            userInfoView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            userInfoView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            userInfoView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -50)
        ])
    }
    
}
