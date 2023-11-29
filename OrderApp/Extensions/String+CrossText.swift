//
//  String+CrossText.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import UIKit


// Cross out the line for sales
extension String {
    
    func crossOutTheLine() -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
}
