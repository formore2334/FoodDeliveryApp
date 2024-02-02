//
//  UITextField+Validate.swift
//  OrderApp
//
//  Created by ForMore on 28/11/2023.
//

import UIKit

extension UITextField {
    
    //Highlight a textfield in green to show thats is valid
    func valid() {
        self.layer.borderColor = UIColor.green.cgColor
    }
    
    //Highlight a textfield in red to show thats is invalid
    func invalid() {
        self.layer.borderColor = UIColor.red.cgColor
    }
    
}
