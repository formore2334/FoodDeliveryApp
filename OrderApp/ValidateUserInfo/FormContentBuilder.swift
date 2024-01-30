//
//  FormContentBuilder.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import Foundation


// Build content for CheckoutList form

final class FormContentBuilder {
    
    var couponsManager = CouponsManager()
    
    let validateManager = ValidateManager()
    
    var userInfo = UserInfo(orderNumber: "", name: "", phone: "", email: "", address: "", comment: "", coupon: "")
    
    // Flag to shake button
    var isValid: Bool {
        if userInfo.name != "" && userInfo.email != "" && userInfo.address != "" && userInfo.phone != "" {
            return true
        }
        return false
    }
    
    
    // Implementation to each case in CheckoutList form
    func updateUserInfo(text: String, for checkoutListItem: CheckoutList, with basket: Basket? = nil) -> (String, Any)? {
        
        switch checkoutListItem {
            
        case .name:
            
            // Validate incoming text
            switch validateManager.validateName(text) {
            case .success(let validText):
                
                // Change UserInfo model
                userInfo.name = validText.capitalized
                return (validText, "")
            case .failure(let errorText):
                userInfo.name = ""
                return ("", errorText.localizedDescription)
            }
            
        case .phone:
            
            // Validate incoming text
            switch validateManager.validatePhoneNumber(text) {
            case .success(let validText):
                
                // Change UserInfo model
                userInfo.phone = validText
                return (validText, "")
            case .failure(let errorText):
                userInfo.phone = ""
                return ("", errorText.localizedDescription)
            }
            
        case .email:
            
            // Validate incoming text
            switch validateManager.validateEmail(text) {
            case .success(let validText):
                
                // Change UserInfo model
                userInfo.email = validText
                return (validText, "")
            case .failure(let errorText):
                userInfo.email = ""
                return ("", errorText.localizedDescription)
            }
            
        case .address:
            
            // Validate incoming text
            switch validateManager.validateAddress(text) {
            case .success(let validText):
                
                // Change UserInfo model
                userInfo.address = validText.capitalized
                return (validText, "")
            case .failure(let errorText):
                userInfo.address = ""
                return ("", errorText.localizedDescription)
            }
            
        case .comment:
            
            // Change UserInfo model
            userInfo.comment = text.capitalized
            return nil
            
        case .coupon:
            
            // Change UserInfo model
            userInfo.coupon = text
            
            guard let basket = basket else { return nil }
            
            // Validate incoming coupon text
            couponsManager.basket = basket
            couponsManager.applyCoupon(text)
            
            // Checks the returned value
            if couponsManager.appliedCouponIsValid {
                
                // Set needs total sum values
                let newTotalSum = couponsManager.calculatedDiscountString
                let totalSum = "\(basket.totalSum)"
                let oldTotalSum = totalSum.crossOutTheLine()
                
                return (newTotalSum, oldTotalSum)
            } else {
                
                // Clear UserInfo model coupon field
                userInfo.coupon = ""
            }
            
        }
        
        return nil
    }
    
    
}
