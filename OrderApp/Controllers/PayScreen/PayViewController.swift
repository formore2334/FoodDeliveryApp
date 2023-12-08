//
//  PayViewController.swift
//  OrderApp
//
//  Created by ForMore on 17/11/2023.
//

import UIKit

class PayViewController: UIViewController {
    
    var userInfo: UserInfo
    
    var basket: Basket
    
    private var paymentManager = PaymentManager()
    
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
    
    
    var containerPortrait: [NSLayoutConstraint] = []
    
    var containerLandscape: [NSLayoutConstraint] = []
    
    var paymentInfoContainerPortrait: [NSLayoutConstraint] = []
    
    var paymentInfoContainerLandscape: [NSLayoutConstraint] = []
   
    
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
      
        navigationController?.navigationBar.tintColor = .black
        
        /// Color set to .white because after exit to home screen navigation color for Sales group is changed
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let isPortrait = UIDevice.current.orientation.isPortrait
        
        if isPortrait {
            NSLayoutConstraint.deactivate(containerLandscape + paymentInfoContainerLandscape)
            NSLayoutConstraint.activate(containerPortrait + paymentInfoContainerPortrait)
        } else {
            if paymentInfoContainer.subviews.first(where: { $0 is PaymentDetailsView }) != nil {
                    NSLayoutConstraint.deactivate(paymentInfoContainerPortrait)
                    NSLayoutConstraint.activate(paymentInfoContainerLandscape)
                } else {
                    NSLayoutConstraint.deactivate(paymentInfoContainerLandscape)
                    NSLayoutConstraint.activate(paymentInfoContainerPortrait)
                }

            NSLayoutConstraint.deactivate(containerPortrait)
            NSLayoutConstraint.activate(containerLandscape)
            
        }
        
    }
    
    //MARK: - Configurations
    
    func configureVC() {
        setContainer()
        setBackgroundColorContainer()
        setPayViewControlsButtons()
        configurePaymentManager()
    }
    
    //MARK: - Set all variables
    
    // Adding all view to containers on screen
    
    func configurePaymentManager() {
        view.addSubview(paymentInfoContainer)

        paymentManager.createOrder(userInfo: userInfo, basket: basket)
        
        paymentManager.configureCheckDetailsView(containerView: paymentInfoContainer)
       
        setPaymentInfoContainerConstraints()
    }
    
    func setPayViewControlsButtons() {
        view.addSubview(controlButtonsContainer)
        
        paymentManager.configureControlButtons(containerView: controlButtonsContainer)
        
        setControlButtonsContainerConstraints()
    }
    
    func setContainer() {
        view.addSubview(container)
        
        setContainerConstraints()
    }
    
    func setBackgroundColorContainer() {
        view.addSubview(backgroundColorContainer)
        
        setBackgroundColorContainerConstraints()
    }
    
    
    //MARK: - Constraints
    
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
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 5),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
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
            paymentInfoContainer.bottomAnchor.constraint(equalTo: controlButtonsContainer.topAnchor, constant: -16)
        ]
        
        paymentInfoContainerLandscape = [
           paymentInfoContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
           paymentInfoContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
           paymentInfoContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
           paymentInfoContainer.bottomAnchor.constraint(equalTo: controlButtonsContainer.topAnchor)
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

//MARK: - Delegat's methods

extension PayViewController: ConformButtonDelegate {
    
    func didTapButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.paymentManager.configurePayControlButton()
        }
    }
    
}

extension PayViewController: PayViewControlButtonsDelegate {
    
    func backButtonDidTap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func payButtonDidTap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.paymentManager.handlePayButtonTap(containerView: self.paymentInfoContainer)
        }
    }
    
    func homeButtonDidTap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.paymentManager.sendNotification()
            self.tabBarController?.selectedIndex = 0
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
}
