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
        Menu(imageName: "cube", title: "Combo", description: "Nice food", menuItem: [
            MenuItem(price: 15.99, imageName: "cube", title: "Combo 1", description: "Good Choise to.."),
            MenuItem(price: 16.99, imageName: "cube", title: "Combo 2", description: "Good Choise to.."),
            MenuItem(price: 20.99, imageName: "cube", title: "Combo 3", description: "Good Choise to.."),
            MenuItem(price: 13.99, imageName: "cube", title: "Combo 4", description: "Good Choise to.."),
            MenuItem(price: 19.99, imageName: "cube", title: "Combo 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Burgers", description: "Nice food", menuItem: [
            MenuItem(price: 11.99, imageName: "cube", title: "Burger 1", description: "Good Choise to.."),
            MenuItem(price: 9.99, imageName: "cube", title: "Burger 2", description: "Good Choise to.."),
            MenuItem(price: 13.99, imageName: "cube", title: "Burger 3", description: "Good Choise to.."),
            MenuItem(price: 11.99, imageName: "cube", title: "Burger 4", description: "Good Choise to.."),
            MenuItem(price: 10.99, imageName: "cube", title: "Burger 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Fries", description: "Nice food", menuItem: [
            MenuItem(price: 5.99, imageName: "cube", title: "Fries 1", description: "Good Choise to.."),
            MenuItem(price: 6.99, imageName: "cube", title: "Fries 2", description: "Good Choise to.."),
            MenuItem(price: 7.99, imageName: "cube", title: "Fries 3", description: "Good Choise to.."),
            MenuItem(price: 8.99, imageName: "cube", title: "Fries 4", description: "Good Choise to.."),
            MenuItem(price: 9.99, imageName: "cube", title: "Fries 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Drinks", description: "Nice food", menuItem: [
            MenuItem(price: 3.99, imageName: "cube", title: "Drink 1", description: "Good Choise to.."),
            MenuItem(price: 5.99, imageName: "cube", title: "Drink 2", description: "Good Choise to.."),
            MenuItem(price: 4.99, imageName: "cube", title: "Drink 3", description: "Good Choise to.."),
            MenuItem(price: 7.99, imageName: "cube", title: "Drink 4", description: "Good Choise to.."),
            MenuItem(price: 2.99, imageName: "cube", title: "Drink 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Souses", description: "Nice food", menuItem: [
            MenuItem(price: 2.99, imageName: "cube", title: "Souse 1", description: "Good Choise to.."),
            MenuItem(price: 2.99, imageName: "cube", title: "Souse 2", description: "Good Choise to.."),
            MenuItem(price: 3.99, imageName: "cube", title: "Souse 3", description: "Good Choise to.."),
            MenuItem(price: 5.99, imageName: "cube", title: "Souse 4", description: "Good Choise to.."),
            MenuItem(price: 1.99, imageName: "cube", title: "Souse 5", description: "Good Choise to..")
            ]),
//        Menu(imageName: "cube", title: "Chicken", description: "Nice food", menuItem: [
//            MenuItem(price: 8.99, imageName: "cube", title: "Chicken 1", description: "Good Choise to.."),
//            MenuItem(price: 15.99, imageName: "cube", title: "Chicken 2", description: "Good Choise to.."),
//            MenuItem(price: 11.99, imageName: "cube", title: "Chicken 3", description: "Good Choise to.."),
//            MenuItem(price: 13.99, imageName: "cube", title: "Chicken 4", description: "Good Choise to.."),
//            MenuItem(price: 19.99, imageName: "cube", title: "Chicken 5", description: "Good Choise to..")
//            ])
    ]
}
