//
//  SalesModel.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import Foundation


struct Sale: Identifiable, Decodable {
    let id: Int
    let previewImageURL: String
    let backgroundImageURL: String
    let title: String
    let textHeadline: String
    let textDescription: String
    var menuItemsID: [Int]? = nil
}
