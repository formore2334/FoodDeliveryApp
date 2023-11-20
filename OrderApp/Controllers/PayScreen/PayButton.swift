//
//  PayButton.swift
//  OrderApp
//
//  Created by ForMore on 17/11/2023.
//

import UIKit


class PayButton: UIView {
    
    var basket: Basket?

    private var payButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pay", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.init(red: 51/255, green: 153/255, blue: 255/255, alpha: 0.9)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(payButton)
        configurePayButton()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configurePayButton() {
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    }
    
    @objc private func payButtonTapped() {
      //  guard let basket = basket else { return }
        let payVC = PayViewController()
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {

            navigationController.pushViewController(payVC, animated: true)
        }
    }

    //MARK: - Constraints
    
    private func setConstraints() {
        payButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            payButton.topAnchor.constraint(equalTo: topAnchor),
            payButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            payButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
