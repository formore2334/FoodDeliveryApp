//
//  PaymentDataLoader.swift
//  OrderApp
//
//  Created by ForMore on 06/12/2023.
//

import Foundation

class PaymentDataLoader {
    
    let loadingView = LoadingView()
    
    // Getting Payment System from outside
    func getPaymentWindow(completion: @escaping () -> Void) {
        loadingView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadingView.stopAnimating()
            completion()
        }
    }
    
    // Awaiting response from outside
    func processPayment(completion: @escaping () -> Void) {
        loadingView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.loadingView.stopAnimating()
            completion()
        }
    }
    
    
}
