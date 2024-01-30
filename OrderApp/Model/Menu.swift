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

// Creates custom CodingKeys to hanling formatting characters \t, \n from JSON

extension RegularMenuItem {
    
    private enum CodingKeys: String, CodingKey {
        case id, price, imageURL, title, description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        price = try container.decode(Double.self, forKey: .price)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        title = try container.decode(String.self, forKey: .title)
        
        // Replace special formatting characters
        let rawDescription = try container.decode(String.self, forKey: .description)
        description = rawDescription.replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\t", with: "\t")
    }
    
}

extension DiscountMenuItem {
    
    private enum CodingKeys: String, CodingKey {
        case id, price, imageURL, title, description, sale
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        price = try container.decode(Double.self, forKey: .price)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        title = try container.decode(String.self, forKey: .title)
        sale = try container.decode(Int.self, forKey: .sale)
        
        // Replace special formatting characters
        let rawDescription = try container.decode(String.self, forKey: .description)
        description = rawDescription.replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\t", with: "\t")
    }
    
}

extension SpecialMenuItem {
    
    private enum CodingKeys: String, CodingKey {
        case id, price, imageURL, title, description, sale
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        price = try container.decode(Double.self, forKey: .price)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        title = try container.decode(String.self, forKey: .title)
        sale = try container.decode(Int.self, forKey: .sale)
        
        // Replace special formatting characters
        let rawDescription = try container.decode(String.self, forKey: .description)
        description = rawDescription.replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\t", with: "\t")
    }
    
}
