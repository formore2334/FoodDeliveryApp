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
    var basketItems: [BasketItem]
    
    var totalCount: Int {
        return basketItems.reduce(0) { $0 + $1.count }
    }
    
    var totalSum: Double {
        let sum = basketItems.reduce(0.0) { result, basketItem in
            let menuItem = basketItem.menuItem
            
            if let discountMenuItem = menuItem as? Discountble {
                return result + (discountMenuItem.newPrice * Double(basketItem.count))
            } else {
                return result + (menuItem.price * Double(basketItem.count))
            }
        }
        
        return Double(String(format: "%.2f", sum)) ?? 0.0
    }
    
}

extension Basket {
    static let mockData = Basket(basketItems: [
        BasketItem(menuItem: MenuItem(price: 5.99, imageURL: "https://img.freepik.com/premium-photo/french-fries-craft-paper-box-wooden-board-top-view-with-copy-space_251318-209.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Fries 1", description: ""), count: 2),
        BasketItem(menuItem: MenuItem(price: 16.99, imageURL: "https://img.freepik.com/free-photo/juicy-chicken-burger-with-fresh-lettuce-crispy-french-fries-wooden-board_181624-50895.jpg?w=740&t=st=1700537979~exp=1700538579~hmac=28d40a83d2b501972bd2f11eb31058d8686dc2d8125aee22e7e94e609b6a7a67", title: "Combo 2", description: ""), count: 1),
        BasketItem(menuItem: MenuItem(price: 3.99, imageURL: "https://img.freepik.com/free-photo/beautiful-cold-drink-cola-with-ice-cubes_1150-26255.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Drink 1", description: ""), count: 2)
    ])
}
