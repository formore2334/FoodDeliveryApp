//
//  SalesModel.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import Foundation


struct Sale {
    let imageName: String
    let title: String
    let description: String
}


extension Sale {
    static let mockData: [Sale] = [
    Sale(imageName: "cube", title: "Burger's waterfall", description: "Your chanse to..."),
    Sale(imageName: "cube", title: "Happy Friday", description: "Your chanse to..."),
    Sale(imageName: "cube", title: "First delivery sale", description: "Your chanse to..."),
    Sale(imageName: "cube", title: "Hot Chicken Days", description: "Your chanse to..."),
    Sale(imageName: "cube", title: "Strip for step", description: "Your chanse to...")
    ]
}
