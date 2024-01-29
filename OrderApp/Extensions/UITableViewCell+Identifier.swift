//
//  UITableViewCell+Identifier.swift
//  OrderApp
//
//  Created by ForMore on 28/11/2023.
//

import UIKit

// Extension with static identifier for any cell inherited from UITableViewCell class
                                        
extension UITableViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
    
}
