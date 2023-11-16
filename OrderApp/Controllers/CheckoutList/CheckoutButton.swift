//
//  GoToCheckoutListButton.swift
//  OrderApp
//
//  Created by ForMore on 16/11/2023.
//

import UIKit


class CheckoutButton: UIView {
    
    var basket: Basket?

    private var checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 400, height: 60)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.red
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(checkoutButton)
        configureCheckoutButton()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCheckoutButton() {
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkoutButtonTapped() {
        guard let basket = basket else { return }
        let checkoutListVC = CheckoutListViewController(basket: basket)
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {

            navigationController.pushViewController(checkoutListVC, animated: true)
        }
    }

    //MARK: - Constraints
    
    private func setConstraints() {
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkoutButton.topAnchor.constraint(equalTo: topAnchor),
            checkoutButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkoutButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
