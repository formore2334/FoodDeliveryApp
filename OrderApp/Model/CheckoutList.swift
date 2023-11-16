//
//  CheckoutList.swift
//  OrderApp
//
//  Created by ForMore on 16/11/2023.
//

import Foundation


enum CheckoutListInfo: String {
    case name = "Name"
    case phone = "Phone Number"
    case address = "Address"
    case comment = "Comment"
    case coupon = "Coupon"
}

struct CheckoutList {
    var name: String
    var phone: String
    var address: String
    var comment: String
    var coupon: String

}
