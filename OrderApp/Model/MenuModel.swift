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


