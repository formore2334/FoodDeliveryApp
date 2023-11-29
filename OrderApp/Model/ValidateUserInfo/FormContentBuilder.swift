//
//  FormContentBuilder.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import Foundation


// Build content for CheckoutList form

class FormContentBuilder {
    
    var salesManager = SalesManager()
    
    let validateManager = ValidateManager()
    
    var userInfo = UserInfo(name: "", phone: "", email: "", address: "", comment: "", coupon: "") {
        didSet {
           // print("DEBUG checkoutList: ", userInfo)
        }
    }
    
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
            switch validateManager.validateName(text) {
            case .success(let validText):
                userInfo.name = validText.capitalized
                return (validText, "")
            case .failure(let errorText):
                userInfo.name = ""
                return ("", errorText.localizedDescription)
            }
            
        case .phone:
            switch validateManager.validatePhoneNumber(text) {
            case .success(let validText):
                userInfo.phone = validText
                return (validText, "")
            case .failure(let errorText):
                userInfo.phone = ""
                return ("", errorText.localizedDescription)
            }
            
        case .email:
            switch validateManager.validateEmail(text) {
            case .success(let validText):
                userInfo.email = validText
                return (validText, "")
            case .failure(let errorText):
                userInfo.email = ""
                return ("", errorText.localizedDescription)
            }
        case .address:
            switch validateManager.validateAddress(text) {
            case .success(let validText):
                userInfo.address = validText.capitalized
                return (validText, "")
            case .failure(let errorText):
                userInfo.address = ""
                return ("", errorText.localizedDescription)
            }
            
        case .comment:
            userInfo.comment = text.capitalized
            return nil
            
        case .coupon:
            userInfo.coupon = text
            
            guard let basket = basket else { return nil }
            
            // Returned values for total label's
            salesManager.basket = basket
            salesManager.applyCoupon(text)
            
            if salesManager.couponIsValid {
                
                let calculatedDiscount = salesManager.calculatedDiscountString
                let totalSum = "\(basket.totalSum)"
                let discount = totalSum.crossOutTheLine()
                
                return (calculatedDiscount, discount)
            }
        }
        return nil
        
    }
    
    
}
