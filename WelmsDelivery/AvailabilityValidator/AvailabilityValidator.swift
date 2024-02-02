//
//  AvailabilityValidator.swift
//  OrderApp
//
//  Created by ForMore on 24/12/2023.
//

import Foundation


protocol AvailabilityValidatorDelegate: AnyObject {
    func unavailableItemsDidChange()
}

final class AvailabilityValidator {
    
    var unavailableItems: [Int] = []
    
    weak var delegate: AvailabilityValidatorDelegate?
    
    init() {
        
        // Listens to notification from BasketManager
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getUnavailableItems),
                                               name: .basketSpecialItemsDidCange,
                                               object: nil)
        
    }
    
    // Receives array of all unavailable special menuItem's from basket
    @objc private func getUnavailableItems(notification: NSNotification) {
        guard let basketSpecialItems = notification.object as? [BasketSpecialItem] else { return }
        
        unavailableItems = []
        
        for basketSpecialItem in basketSpecialItems {
            unavailableItems.append(basketSpecialItem.saleID)
        }
        
        delegate?.unavailableItemsDidChange()
    }
    
    
}
