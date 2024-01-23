//
//  String+Hyperlink.swift
//  OrderApp
//
//  Created by ForMore on 21/01/2024.
//

import UIKit


extension String {
    
    // Finds hyperlink inside text
    func extractHyperlinkText(in text: String) -> String {
        
        // Sets hyperlink detector
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        // Apply detector to search for matches along the entire length of the text
        let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        // Iterates through the found matches
        for match in matches {
            
            // If founds url, returnes it as string
            guard let url = match.url else { continue }
            return String(describing: url)
        }
        
        // If matches not found, returnes empty string
        return ""
    }
    
}
