//
//  Double+Format.swift
//  OrderApp
//
//  Created by ForMore on 21/12/2023.
//

import Foundation


extension Double {
    
    func twoDigitsFormat() -> Double {
        return Double(String(format: "%.2f", self)) ?? 0.0
    }
    
}
