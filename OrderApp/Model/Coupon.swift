//
//  Coupon.swift
//  OrderApp
//
//  Created by ForMore on 22/11/2023.
//

import Foundation

struct Coupon: Identifiable, Decodable {
    let id: Int
    let title: String
    let imageURL: String
    let description: String
    let discountKeyWord: String
    let discountValue: Int
}
