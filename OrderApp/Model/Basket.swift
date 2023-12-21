//
//  Bascket.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import Foundation


struct BasketItem {
    let menuItem: (any MenuItemProtocol)
    var count: Int
}

struct Basket {
    var basketItems: [BasketItem]
    
    var totalCount: Int {
        return basketItems.reduce(0) { $0 + $1.count }
    }
    
    var totalSum: Double {
        let sum = basketItems.reduce(0.0) { result, basketItem in
            let menuItem = basketItem.menuItem
            
            if let discountMenuItem = menuItem as? (any Discountable) {
                return result + (discountMenuItem.newPrice * Double(basketItem.count))
            } else {
                return result + (menuItem.price * Double(basketItem.count))
            }
        }
        
        return sum.twoDigitsFormat()
    }
    
}
