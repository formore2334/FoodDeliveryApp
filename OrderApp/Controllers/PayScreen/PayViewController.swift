//
//  PayViewController.swift
//  OrderApp
//
//  Created by ForMore on 17/11/2023.
//

import UIKit

final class PayViewController: UIViewController {
    
    var userInfo: UserInfo
    
    var basket: Basket
    
    private var paymentManager = PaymentManager()
    
    // MARK: - Set variables
    
    private var controlButtonsContainer = UIView()
    
    private var paymentInfoContainer = UIView()
    
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .gray
        container.layer.opacity = 0.5
        container.layer.cornerRadius = 25
        return container
    }()
    
    private lazy var backgroundColorContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(named: "lightBlueTranslucent")
        return container
    }()
    
    // Setup holders to movable constraints
    private var containerPortrait: [NSLayoutConstraint] = []
    
    private var containerLandscape: [NSLayoutConstraint] = []
    
    private var paymentInfoContainerPortrait: [NSLayoutConstraint] = []
    
    private var paymentInfoContainerLandscape: [NSLayoutConstraint] = []
   
    // MARK: - Init
    
    init(userInfo: UserInfo, basket: Basket) {
        self.userInfo = userInfo
        self.basket = basket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Payment"
        view.backgroundColor = .systemGray5
        
        paymentManager.setupDelegates(delegate: self)
        
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        // Sets color of navigation items to black
        navigationController?.navigationBar.tintColor = .black
        
        // Color set to .white because after exit to home screen
        // Navigation color for Sales group is changed
        UIBarButtonItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white],
                                                            for: .normal)
    }
    
    // Change layout with device orientation
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        // Setup constraints based on orientation
        if isLandscape {
            NSLayoutConstraint.deactivate(containerPortrait)
            NSLayoutConstraint.activate(containerLandscape)
            
            NSLayoutConstraint.deactivate(paymentInfoContainerPortrait)
            NSLayoutConstraint.activate(paymentInfoContainerLandscape)
        } else {
            NSLayoutConstraint.deactivate(containerLandscape)
            NSLayoutConstraint.activate(containerPortrait)
            
            NSLayoutConstraint.deactivate(paymentInfoContainerLandscape)
            NSLayoutConstraint.activate(paymentInfoContainerPortrait)
        }
        
    }
    
    //MARK: - Configurations
    
    private func configureVC() {
        setContainer()
        setBackgroundColorContainer()
        setPayViewControlsButtons()
        configurePaymentManager()
    }
    
    // Adding all view to containers on screen
    
    // Config with paymentManager methods
    private func configurePaymentManager() {
        view.addSubview(paymentInfoContainer)

        paymentManager.createOrder(userInfo: userInfo, basket: basket)
        
        paymentManager.configureCheckDetailsView(containerView: paymentInfoContainer)
       
        setPaymentInfoContainerConstraints()
    }
    
    // Config with paymentManager methods
    private func setPayViewControlsButtons() {
        view.addSubview(controlButtonsContainer)
        
        paymentManager.configureControlButtons(containerView: controlButtonsContainer)
        
        setControlButtonsContainerConstraints()
    }
    
    private func setContainer() {
        view.addSubview(container)
        
        setContainerConstraints()
    }
    
    private func setBackgroundColorContainer() {
        view.addSubview(backgroundColorContainer)
        
        setBackgroundColorContainerConstraints()
    }

}

//MARK: - Delegat's methods

extension PayViewController: ConformButtonDelegate {
    
    func didTapButton() {
        
        // Delay simulates the operation of the request
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
            self?.paymentManager.configurePayControlButton()
        }
        
    }
    
}

extension PayViewController: PayViewControlButtonsDelegate {
    
    func backButtonDidTap() {
        
        // Delay simulates the operation of the request
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func payButtonDidTap() {
        
        // Delay simulates the operation of the request
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            
            self.paymentManager.handlePayButtonTap(containerView: self.paymentInfoContainer)
        }
        
    }
    
    func homeButtonDidTap() {
        
        // Delay just for good appearance
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            
            self.paymentManager.sendNotification()
            self.tabBarController?.selectedIndex = 0
            self.navigationController?.popToRootViewController(animated: false)
        }
        
    }
    
}

//MARK: - Constraints

private extension PayViewController {

    func setContainerConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        
        containerPortrait = [
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            container.heightAnchor.constraint(equalToConstant: 350)
        ]
    
        containerLandscape = [
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ]
       
    }
    
    func setBackgroundColorContainerConstraints() {
        backgroundColorContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundColorContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundColorContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundColorContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundColorContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setPaymentInfoContainerConstraints() {
        paymentInfoContainer.translatesAutoresizingMaskIntoConstraints = false
        
        paymentInfoContainerPortrait = [
            paymentInfoContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            paymentInfoContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            paymentInfoContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            paymentInfoContainer.bottomAnchor.constraint(equalTo: controlButtonsContainer.topAnchor, constant: -10)
        ]
        
        paymentInfoContainerLandscape = [
            paymentInfoContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            paymentInfoContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            paymentInfoContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            paymentInfoContainer.bottomAnchor.constraint(equalTo: controlButtonsContainer.topAnchor, constant: 10)
        ]
    }
    
    func setControlButtonsContainerConstraints() {
        controlButtonsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controlButtonsContainer.heightAnchor.constraint(equalToConstant: 40),
            controlButtonsContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            controlButtonsContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            controlButtonsContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
    
}
