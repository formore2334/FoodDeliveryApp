//
//  SalesManager.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import Foundation


struct CouponsManager {

    private let coupons: [Coupon] = Coupon.mockData
    
    private var appliedCoupon: Coupon?
    
    var basket: Basket?
    
    var couponIsValid: Bool = false
    
    // Prepared value for discount label
    var calculatedDiscountString: String {
        return "\(calculateDiscount())"
    }
    
    init(basket: Basket? = nil) {
        self.basket = basket
    }
    
    
    func calculateDiscount() -> Double {
        guard let appliedCoupon = appliedCoupon, let basket = basket else { return basket?.totalSum ?? 0 }
        let discount = basket.totalSum - (basket.totalSum / 100 * Double(appliedCoupon.discountValue))
        return Double(String(format: "%.2f", discount)) ?? 0.0
    }
    
    mutating func applyCoupon(_ couponKeyWord: String) {
        guard let coupon = coupons.first(where: { $0.discountKeyWord == couponKeyWord }) else {
            self.couponIsValid = false
            return
        }
        
        appliedCoupon = coupon
        self.couponIsValid = true
    }

}
