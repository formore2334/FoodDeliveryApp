//
//  PaymentManager.swift
//  OrderApp
//
//  Created by ForMore on 05/12/2023.
//

import UIKit


struct PaymentManager {
    
    var userOrder: UserOrder?
    
    private var checkDetailsView = CheckDetailsView()
    
    private var paymentDetailsView = PaymentDetailsView()
    
    private var billView = BillView()
    
    private var controlButtons = PayViewControlButtons()
    
    private var paymentDataLoader = PaymentDataLoader()
    
    
    // Setup delegates with one method
    func setupDelegates(delegate: PayViewControlButtonsDelegate & ConformButtonDelegate) {
        checkDetailsView.delegate = delegate
        controlButtons.delegate = delegate
    }
    
    // Create new UserOrder model for the needs of other view's
    mutating func createOrder(userInfo: UserInfo, basket: Basket) {
        var updatedUserInfo = userInfo
        
        //assigning random number to user order
        updatedUserInfo.orderNumber = String(format: "%08d", Int.random(in: 0..<100000000))
        
        let order = UserOrder(userInfo: updatedUserInfo, basket: basket)
        userOrder = order
    }
    
    // Setup CheckDetailsView in PayVC
    func configureCheckDetailsView(containerView: UIView) {
        containerView.addSubview(checkDetailsView)
        checkDetailsView.pinToBounds(to: containerView)
        
        configureCheckDetailsView()
    }
    
    // Setup ControlButtons in PayVC
    func configureControlButtons(containerView: UIView) {
        containerView.addSubview(controlButtons)
        controlButtons.pinToBounds(to: containerView)
    }
    
    // Send notification when home button was tapped to clear basket & return from secondary vc to home (optional)
    func sendNotification() {
        NotificationCenter.default.post(name: Notification.Name("BackToHomeNotification"), object: nil)
    }
    
    // Configure checkDetailsView. Used inside this manager
    private func configureCheckDetailsView() {
        guard let userOrder = userOrder else { return }
        
        checkDetailsView.configure(with: userOrder.userInfo)
    }
    
    // Configure when delegat was triggered
    func configurePayControlButton() {
        controlButtons.configurePayButton()
    }
    
    // Handle each view container according to pressing pay button
    func handlePayButtonTap(containerView: UIView) {
        guard let userOrder = userOrder else { return }
        
        // When pay button is pressed once to main container is added next view
        if self.paymentDetailsView.superview == nil {
            
            self.checkDetailsView.removeFromSuperview()
            
            containerView.addSubview(paymentDataLoader.loadingView)
            paymentDataLoader.loadingView.pinToBounds(to: containerView)
            
            // Delay to project the appearance of work
            paymentDataLoader.getPaymentWindow { //[weak self] in
                DispatchQueue.main.async {
                    // guard let self = self else { return }
                    self.paymentDataLoader.loadingView.removeFromSuperview()
                    
                    containerView.addSubview(self.paymentDetailsView)
                    
                    self.paymentDetailsView.configure(with: userOrder)
                    self.paymentDetailsView.pinToBounds(to: containerView)
                }
            }
            
            // When pay button is pressed twice to main container is added last view
        } else if self.billView.superview == nil {
            
            self.paymentDetailsView.removeFromSuperview()
            
            containerView.addSubview(paymentDataLoader.loadingView)
            paymentDataLoader.loadingView.pinToBounds(to: containerView)
            
            // Delay to project the appearance of work
            paymentDataLoader.processPayment { //[weak self] in
                DispatchQueue.main.async {
                    // guard let self = self else { return }
                    self.paymentDataLoader.loadingView.removeFromSuperview()
                    
                    containerView.addSubview(self.billView)
                    
                    self.billView.configure(with: userOrder)
                    self.billView.pinToBounds(to: containerView)
                    
                    self.controlButtons.setHomeButton()
                }
            }
            
        }
        
    }
    
    
}
