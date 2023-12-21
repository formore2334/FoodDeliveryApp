//
//  MenuModel.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import Foundation


protocol MenuItemProtocol: Identifiable, Decodable {
    var id: Int { get }
    var price: Double { get }
    var imageURL: String { get }
    var title: String { get }
    var description: String { get }
}

protocol Discountable: MenuItemProtocol {
    var sale: Int { get }
    var newPrice: Double { get }
}

extension Discountable {
    var newPrice: Double {
        let newPrice = price - (price / 100 * Double(sale))
        return newPrice.twoDigitsFormat()
    }
}

struct Menu: Identifiable {
    let id: Int
    let imageName: String
    let title: String
    var menuItems: [any MenuItemProtocol]
}

struct RegularMenuItem: MenuItemProtocol {
    let id: Int
    var price: Double
    var imageURL: String
    var title: String
    var description: String
}

struct DiscountMenuItem: MenuItemProtocol, Discountable {
    let id: Int
    var price: Double
    var imageURL: String
    var title: String
    var description: String
    var sale: Int
}

struct SpecialMenuItem: MenuItemProtocol, Discountable {
    let id: Int
    var price: Double
    var imageURL: String
    var title: String
    var description: String
    var sale: Int
}
