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

struct BasketSpecialItem {
    let saleID: Int
    let discountTitle: String
    let specialMenuItems: [SpecialItem]
    
    struct SpecialItem {
        let menuItem: SpecialMenuItem
        var count: Int
    }
    
    // Returnes total sum of all special items
    var totalSum: Double {
        let specialItemsSum = specialMenuItems.reduce(0.0) { result, specialItem in
            return result + (specialItem.menuItem.newPrice * Double(specialItem.count))
        }
        
        return specialItemsSum
    }

}

struct Basket {
    var basketItems: [BasketItem]
    var basketSpecialItems: [BasketSpecialItem]
    
    // Returnes total count of basket items & basket special items
    var totalCount: Int {
        let totalCount = (basketItems.reduce(0) { $0 + $1.count }) + (basketSpecialItems.count)
        return totalCount
    }
    
    // Returnes total sum of basket items + basket special items
    var totalSum: Double {
        
        // Finds regular basket menuItem's sum of price
        let basketItemsSum = basketItems.reduce(0.0) { result, basketItem in
            let menuItem = basketItem.menuItem
            
            if let discountMenuItem = menuItem as? (any Discountable) {
                
                // Returnes sum of new price
                return result + (discountMenuItem.newPrice * Double(basketItem.count))
            } else {
                
                // Returnes sum of old price
                return result + (menuItem.price * Double(basketItem.count))
            }
        }
        
        // Finds special basket menuItem's sum of price
        let basketSpecialItemsSum = basketSpecialItems.reduce(0.0) { result, specialItem in
            return result + specialItem.totalSum
        }
        
        // Finds total sum of price both arrays
        let totalSum = basketItemsSum + basketSpecialItemsSum
        
        return totalSum.twoDigitsFormat()
    }
    
}
