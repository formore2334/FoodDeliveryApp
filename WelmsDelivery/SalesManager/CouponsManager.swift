//
//  SalesManager.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import Foundation


struct CouponsManager {

    private let coupons: [Coupon]
    
    var basket: Basket?
    
    private var appliedCoupon: Coupon?
    
    var appliedCouponIsValid: Bool = false
    
    // Prepared value for discount label
    var calculatedDiscountString: String {
        return "\(calculateDiscount())"
    }
    
    init(coupons: [Coupon] = DataService.shared.coupons,
         basket: Basket? = nil) {
        self.coupons = coupons
        self.basket = basket
    }
    
    // Finds discount value
    func calculateDiscount() -> Double {
        guard let appliedCoupon = appliedCoupon, let basket = basket else { return basket?.totalSum ?? 0 }
        
        let discount = basket.totalSum - (basket.totalSum / 100 * Double(appliedCoupon.discountValue))
        
        return discount.twoDigitsFormat()
    }
    
    // Checks string for match with coupon key word & apply this coupon
    mutating func applyCoupon(_ couponKeyWord: String) {
        guard let coupon = coupons.first(where: { $0.discountKeyWord == couponKeyWord }) else {
            self.appliedCouponIsValid = false
            return
        }
        
        appliedCoupon = coupon
        self.appliedCouponIsValid = true
    }

}
