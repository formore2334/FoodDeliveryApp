//
//  CheckoutList.swift
//  OrderApp
//
//  Created by ForMore on 16/11/2023.
//

import Foundation


enum CheckoutList: String {
    case name = "Name"
    case phone = "Phone Number"
    case email = "Email"
    case address = "Address"
    case comment = "Comment"
    case coupon = "Coupon"
}

enum CheckoutListError: String, CaseIterable, Error {
    case name = "Name is invalid"
    case phone = "Invalid phone number"
    case email = "Missing @ char"
    case address = "Address should be higher then 6 chars"
    case coupon = "Coupon not valid"
}

struct UserInfo {
    var name: String
    var phone: String
    var email: String
    var address: String
    var comment: String
    var coupon: String

}
