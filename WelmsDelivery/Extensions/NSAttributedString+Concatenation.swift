//
//  NSAttributedString+Concatenation.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import UIKit


extension NSAttributedString {
    
    // Prepare strings for cross out rhs
    func concatenationWithCrossOut(baseString: String, crossedString: String, crossedStringFontSize: CGFloat = 15) -> NSAttributedString {
        
        let crossAttributedString = NSMutableAttributedString(string: crossedString)
        
        // Change font size
        let font = UIFont.systemFont(ofSize: crossedStringFontSize)
        crossAttributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: crossAttributedString.length))

        // Cross Out
        crossAttributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, crossAttributedString.length))
    
        // Shift the attributed string upward
        let baselineOffset: CGFloat = 7.0
        crossAttributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: baselineOffset, range: NSRange(location: 0, length: crossAttributedString.length))

        
        let baseAttributedString = NSMutableAttributedString(string: baseString)
        
        // Shift the attributed string upward
        baseAttributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: 4.5, range: NSRange(location: 0, length: baseAttributedString.length))
        
        baseAttributedString.append(crossAttributedString)

        let preparedAttributedString = NSAttributedString(attributedString: baseAttributedString)
        
        return preparedAttributedString
    }
    
}
