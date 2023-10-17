//
//  MenuModel.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import Foundation


struct MenuItem {
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
            MenuItem(imageName: "cube", title: "Combo 1", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Combo 2", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Combo 3", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Combo 4", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Combo 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Burgers", description: "Nice food", menuItem: [
            MenuItem(imageName: "cube", title: "Burger 1", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Burger 2", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Burger 3", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Burger 4", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Burger 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Fries", description: "Nice food", menuItem: [
            MenuItem(imageName: "cube", title: "Fries 1", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Fries 2", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Fries 3", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Fries 4", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Fries 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Drinks", description: "Nice food", menuItem: [
            MenuItem(imageName: "cube", title: "Drinks 1", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Drinks 2", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Drinks 3", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Drinks 4", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Drinks 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Souses", description: "Nice food", menuItem: [
            MenuItem(imageName: "cube", title: "Souses 1", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Souses 2", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Souses 3", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Souses 4", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Souses 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "cube", title: "Chicken", description: "Nice food", menuItem: [
            MenuItem(imageName: "cube", title: "Chicken 1", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Chicken 2", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Chicken 3", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Chicken 4", description: "Good Choise to.."),
            MenuItem(imageName: "cube", title: "Chicken 5", description: "Good Choise to..")
            ])
    ]
}
