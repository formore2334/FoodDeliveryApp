//
//  String+CrossText.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import UIKit

// Extension with attributed string

extension String {
    
    // Cross out the string
    func crossOutTheLine() -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
}
