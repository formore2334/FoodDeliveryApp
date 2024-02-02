//
//  Notification.Name+Extension.swift
//  OrderApp
//
//  Created by ForMore on 24/01/2024.
//

import Foundation


extension Notification.Name {
    static let backToHome = Notification.Name("BackToHomeNotification")
    
    static let basketDidOpen = NSNotification.Name("BasketDidOpenNotification")
    static let basketSpecialItemsDidCange = Notification.Name("BasketSpecialItemsDidCangeNotification")
    
    static let errorValueChanged = NSNotification.Name("ErrorValueChangedNotification")
}
