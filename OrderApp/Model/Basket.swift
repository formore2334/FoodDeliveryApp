//
//  Bascket.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import Foundation


struct BasketItem {
    let menuItem: MenuItem
    var count: Int
}

struct Basket {
    
    var basketItems: [BasketItem] {
        didSet {
            print("DEBUG: ", basketItems.count)
            print("DEBUG: ", basketItems)
        }
    }
    
    var totalCount: Int {
        return basketItems.reduce(0) { $0 + $1.count }
    }
    
    var totalSum: Double {
        let sum = basketItems.reduce(0) { $0 + ($1.menuItem.price * Double($1.count)) }
        return Double(String(format: "%.2f", sum)) ?? 0.0
    }
    
}

extension Basket {
    static let mockData = Basket(basketItems: [
        BasketItem(menuItem: MenuItem(price: 5.99, imageName: "cube", title: "Fries 1", description: ""), count: 2),
        BasketItem(menuItem: MenuItem(price: 16.99, imageName: "cube", title: "Combo 2", description: ""), count: 1),
        BasketItem(menuItem: MenuItem(price: 3.99, imageName: "cube", title: "Drink 1", description: ""), count: 2)
    ])
}
