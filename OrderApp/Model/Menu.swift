//
//  MenuModel.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import Foundation


struct MenuItem: Hashable {
    let price: Double
    let imageName: String
    let title: String
    let description: String
}

struct Menu {
    let imageName: String
    let title: String
    let description: String
    let menuItem: [MenuItem]
}

extension Menu {
    static let mockData: [Menu] = [
        Menu(imageName: "comboLogo", title: "Combo", description: "Nice food", menuItem: [
            MenuItem(price: 15.99, imageName: "combo1", title: "Combo 1", description: "Good Choise to.."),
            MenuItem(price: 16.99, imageName: "combo2", title: "Combo 2", description: "Good Choise to.."),
            MenuItem(price: 20.99, imageName: "combo3", title: "Combo 3", description: "Good Choise to.."),
            MenuItem(price: 13.99, imageName: "combo4", title: "Combo 4", description: "Good Choise to.."),
            MenuItem(price: 19.99, imageName: "combo5", title: "Combo 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "burgerLogo", title: "Burgers", description: "Nice food", menuItem: [
            MenuItem(price: 11.99, imageName: "burger1", title: "Burger 1", description: "Good Choise to.."),
            MenuItem(price: 9.99, imageName: "burger2", title: "Burger 2", description: "Good Choise to.."),
            MenuItem(price: 13.99, imageName: "burger3", title: "Burger 3", description: "Good Choise to.."),
            MenuItem(price: 11.99, imageName: "burger4", title: "Burger 4", description: "Good Choise to.."),
            MenuItem(price: 10.99, imageName: "burger5", title: "Burger 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "friesLogo", title: "Fries", description: "Nice food", menuItem: [
            MenuItem(price: 5.99, imageName: "fries1", title: "Fries 1", description: "Good Choise to.."),
            MenuItem(price: 6.99, imageName: "cube", title: "Fries 2", description: "Good Choise to.."),
            MenuItem(price: 7.99, imageName: "cube", title: "Fries 3", description: "Good Choise to.."),
            MenuItem(price: 8.99, imageName: "cube", title: "Fries 4", description: "Good Choise to.."),
            MenuItem(price: 9.99, imageName: "cube", title: "Fries 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "drinkLogo", title: "Drinks", description: "Nice food", menuItem: [
            MenuItem(price: 3.99, imageName: "cube", title: "Drink 1", description: "Good Choise to.."),
            MenuItem(price: 5.99, imageName: "cube", title: "Drink 2", description: "Good Choise to.."),
            MenuItem(price: 4.99, imageName: "cube", title: "Drink 3", description: "Good Choise to.."),
            MenuItem(price: 7.99, imageName: "cube", title: "Drink 4", description: "Good Choise to.."),
            MenuItem(price: 2.99, imageName: "cube", title: "Drink 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "souseLogo", title: "Souses", description: "Nice food", menuItem: [
            MenuItem(price: 2.99, imageName: "cube", title: "Souse 1", description: "Good Choise to.."),
            MenuItem(price: 2.99, imageName: "cube", title: "Souse 2", description: "Good Choise to.."),
            MenuItem(price: 3.99, imageName: "cube", title: "Souse 3", description: "Good Choise to.."),
            MenuItem(price: 5.99, imageName: "cube", title: "Souse 4", description: "Good Choise to.."),
            MenuItem(price: 1.99, imageName: "cube", title: "Souse 5", description: "Good Choise to..")
            ])
    ]
}
