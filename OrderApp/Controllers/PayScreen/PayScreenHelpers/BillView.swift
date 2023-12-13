//
//  BillView.swift
//  OrderApp
//
//  Created by ForMore on 05/12/2023.
//

import UIKit


class BillView: UIView {
    
    private var container = UIView()
    
    private lazy var thankYouLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    private lazy var waitingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    // Return random number in interval 15-60 minutes
    private var orderWaitingTime: String {
        let randomNumber = Int.random(in: 3...12) * 5
        return String(randomNumber)
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configurations
    
    func configure(with userOrder: UserOrder) {
        thankYouLabel.text = userOrder.userInfo.name + "," + " " + "Thank you for your order"
        waitingLabel.text = "Your order #\(userOrder.userInfo.orderNumber) will be delivered within \(orderWaitingTime) minutes"
        emailLabel.text = "We send bill on your Email:" + " " + userOrder.userInfo.email
    }
    
   private func setup() {
        addSubview(container)
        
        container.addSubview(thankYouLabel)
        container.addSubview(waitingLabel)
        container.addSubview(emailLabel)
        
        setConstraints()
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        thankYouLabel.translatesAutoresizingMaskIntoConstraints = false
        waitingLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            thankYouLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            thankYouLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            thankYouLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50),
            
            waitingLabel.topAnchor.constraint(equalTo: thankYouLabel.bottomAnchor, constant: 30),
            waitingLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            waitingLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50),
            
            emailLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            emailLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -70)
        ])
    }
    
}
