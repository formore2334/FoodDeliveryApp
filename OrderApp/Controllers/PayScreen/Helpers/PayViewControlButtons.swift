//
//  PayViewControlButtons.swift
//  OrderApp
//
//  Created by ForMore on 05/12/2023.
//

import UIKit


protocol PayViewControlButtonsDelegate: AnyObject {
    func backButtonDidTap()
    func payButtonDidTap()
    func homeButtonDidTap()
}

final class PayViewControlButtons: UIView {
    
    weak var delegate: PayViewControlButtonsDelegate?
    
    // MARK: - Set variables
    
    private let container = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var homeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.setTitle("Back", for: .normal)
        return button
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.layer.opacity = 0.4
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGreen
        button.setTitle("Pay", for: .normal)
        return button
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 35)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "lightBlue")
        button.setTitle("Home", for: .normal)
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
        addSubview(stackView)
        
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(payButton)
      
        backButtonAction()
        payButtonAction()
        
        setConstraints()
    }
    
    //MARK: - Configurations
    
    // Makes visible pay button
    func configurePayButton() {
        payButton.isEnabled = true
        payButton.layer.opacity = 1.0
    }
    
    // Leaves only home control button on screen
    func setHomeButton() {
        stackView.removeFromSuperview()
        
        addSubview(homeStackView)
        homeStackView.addArrangedSubview(homeButton)
        
        homeButtonAction()
        setHomeConstraints()
    }

}

// MARK: - Buttons actions

private extension PayViewControlButtons {
    
    // Adds go back action delegate
    func backButtonAction() {
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    @objc func backButtonDidTap() {
        delegate?.backButtonDidTap()
        backButton.scaleAnimation()
    }
    
    // Adds pay action delegate
    func payButtonAction() {
        payButton.addTarget(self, action: #selector(payButtonDidTap), for: .touchUpInside)
    }
    
    @objc func payButtonDidTap() {
        delegate?.payButtonDidTap()
        payButton.scaleAnimation()
    }
    
    // Adds home action delegate
    func homeButtonAction() {
        homeButton.addTarget(self, action: #selector(homeButtonDidTap), for: .touchUpInside)
    }
    
    @objc func homeButtonDidTap() {
        delegate?.homeButtonDidTap()
        homeButton.scaleAnimation()
    }
    
}

//MARK: - Constraints

private extension PayViewControlButtons {

    func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setHomeConstraints() {
        homeStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            homeStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            homeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            homeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
}
