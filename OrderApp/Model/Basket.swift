//
//  Bascket.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import Foundation


struct Basket {
    let totalSum: Double
    let menuItems: [MenuItem]
}

extension Basket {
    static let mockData = Basket(totalSum: 0.0, menuItems: [
        MenuItem(price: 5.99, imageName: "cube", title: "Fries 1", description: ""),
        MenuItem(price: 5.99, imageName: "cube", title: "Fries 1", description: ""),
        MenuItem(price: 5.99, imageName: "cube", title: "Fries 1", description: ""),
        MenuItem(price: 5.99, imageName: "cube", title: "Fries 1", description: ""),
        MenuItem(price: 16.99, imageName: "cube", title: "Combo 2", description: ""),
        MenuItem(price: 16.99, imageName: "cube", title: "Combo 2", description: ""),
        MenuItem(price: 3.99, imageName: "cube", title: "Drink 1", description: ""),
        MenuItem(price: 3.99, imageName: "cube", title: "Drink 1", description: "")
    ])
}
