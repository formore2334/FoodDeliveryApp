//
//  RegexPatterns.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import Foundation

enum RegexPatterns {
    static let name = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
    static let phoneNumber = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
    static let emailChars = ".*[@].*"
    static let higherThanSixChars = "^.{6,}$"
}
