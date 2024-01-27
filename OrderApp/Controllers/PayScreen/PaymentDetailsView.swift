//
//  PaymentDetailsView.swift
//  OrderApp
//
//  Created by ForMore on 04/12/2023.
//

import UIKit


class PaymentDetailsView: UIView {
    
    private var userInfoView = UserInfoView()
    
    // MARK: - Set variables
    
    private var container = UIView()
    
    private lazy var topDividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .black
        return dividerView
    }()
    
    private lazy var bottomDividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .black
        return dividerView
    }()
    
    // Container for userInfo
    private lazy var nestedContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 8
        container.backgroundColor = .systemGray5
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.borderWidth = 0.5
        return container
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Pay with Credit Card"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    private lazy var orderNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var totalSumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
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
        addSubview(container)
        
        container.addSubview(headerLabel)
        container.addSubview(nestedContainer)
        
        nestedContainer.addSubview(orderNumberLabel)
        nestedContainer.addSubview(topDividerView)
        nestedContainer.addSubview(userInfoView)
        nestedContainer.addSubview(bottomDividerView)
        nestedContainer.addSubview(totalSumLabel)
        
        setConstraints()
    }
    
    //MARK: - Configurations
    
    func configure(with userOrder: UserOrder) {
        userInfoView.configure(with: userOrder.userInfo, isBillTextStyle: true)
        
        orderNumberLabel.text = "Order #:" + " " + userOrder.userInfo.orderNumber
        totalSumLabel.text = "Total:" + " " + "\(userOrder.basket.totalSum)" + "$"
    }
    
}

//MARK: - Constraints

private extension PaymentDetailsView {

    func setConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        nestedContainer.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        orderNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        totalSumLabel.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        topDividerView.translatesAutoresizingMaskIntoConstraints = false
        bottomDividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            
            headerLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 15),
            
            nestedContainer.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            nestedContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            nestedContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            nestedContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            orderNumberLabel.topAnchor.constraint(equalTo: nestedContainer.topAnchor, constant: 10),
            orderNumberLabel.leadingAnchor.constraint(equalTo: nestedContainer.leadingAnchor, constant: 10),
            orderNumberLabel.heightAnchor.constraint(equalToConstant: 15),
            
            topDividerView.topAnchor.constraint(equalTo: orderNumberLabel.bottomAnchor, constant: 10),
            topDividerView.leadingAnchor.constraint(equalTo: nestedContainer.leadingAnchor, constant: 10),
            topDividerView.trailingAnchor.constraint(equalTo: nestedContainer.trailingAnchor, constant: -10),
            topDividerView.heightAnchor.constraint(equalToConstant: 0.3),
            
            userInfoView.topAnchor.constraint(equalTo: orderNumberLabel.bottomAnchor, constant: 20),
            userInfoView.leadingAnchor.constraint(equalTo: nestedContainer.leadingAnchor, constant: 10),
            userInfoView.trailingAnchor.constraint(equalTo: nestedContainer.trailingAnchor),
            userInfoView.heightAnchor.constraint(equalToConstant: 100),
            
            bottomDividerView.bottomAnchor.constraint(equalTo: totalSumLabel.topAnchor, constant: -10),
            bottomDividerView.leadingAnchor.constraint(equalTo: nestedContainer.leadingAnchor, constant: 10),
            bottomDividerView.trailingAnchor.constraint(equalTo: nestedContainer.trailingAnchor, constant: -10),
            bottomDividerView.heightAnchor.constraint(equalToConstant: 0.3),
            
            totalSumLabel.bottomAnchor.constraint(equalTo: nestedContainer.bottomAnchor, constant: -10),
            totalSumLabel.leadingAnchor.constraint(equalTo: nestedContainer.leadingAnchor, constant: 10),
            totalSumLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
}
