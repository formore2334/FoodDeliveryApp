//
//  NSAttributedString+TextAttachment.swift
//  OrderApp
//
//  Created by ForMore on 29/12/2023.
//

import UIKit


extension UILabel {
    
    func attributedTitleWithImage(title: String, systemImageName: String) {
        let attributedText = NSMutableAttributedString(string: title + " ")
        
        let basketImageAttachment = NSTextAttachment()
        basketImageAttachment.image = UIImage(systemName: systemImageName)
        
        let imageSize = CGSize(width: 35, height: 35)
        basketImageAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: -3.5), size: imageSize)
        
        // Create NSAttributedString with basket image
        let basketImageString = NSAttributedString(attachment: basketImageAttachment)
        
        attributedText.append(basketImageString)
        
        // Set attributes for line
        attributedText.addAttributes([
            .font: UIFont.boldSystemFont(ofSize: 30),
            .foregroundColor: UIColor.black
        ], range: NSRange(location: 0, length: attributedText.length))
        
        self.attributedText = attributedText
    }
    
}
