//
//  Bascket.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import Foundation


struct Bascket {
    let numberOfItems: Int
    let totalSum: Double
    let menuItems: [MenuItem]
}

extension Bascket {
    static let mockData = Bascket(numberOfItems: 3, totalSum: 15.99, menuItems: [
        MenuItem(imageName: "cube", title: "Fries 1", description: ""),
        MenuItem(imageName: "cube", title: "Fries 1", description: ""),
        MenuItem(imageName: "cube", title: "Fries 1", description: ""),
        MenuItem(imageName: "cube", title: "Fries 1", description: ""),
        MenuItem(imageName: "cube", title: "Combo 2", description: ""),
        MenuItem(imageName: "cube", title: "Combo 2", description: ""),
        MenuItem(imageName: "cube", title: "Drink 1", description: ""),
        MenuItem(imageName: "cube", title: "Drink 1", description: "")
    ])
}
