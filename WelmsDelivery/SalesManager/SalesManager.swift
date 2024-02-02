//
//  SalesManager.swift
//  OrderApp
//
//  Created by ForMore on 30/11/2023.
//

import Foundation


struct SalesManager {
    
    var sales: [Sale]
    
    var menu: [Menu]
    
    init(sales: [Sale] = DataService.shared.sales,
         menu: [Menu] = DataService.shared.menu) {
        self.sales = sales
        self.menu = menu
    }
    
    // Returnes menuItem based on id
    func getMenuItem(at id: Int) -> (any MenuItemProtocol)? {
        
        // Finds first match with menuItem id inside menu array
        for menuCategory in menu {
            if let menuItem = menuCategory.menuItems.first(where: { $0.id == id }) {
                return menuItem
            }
        }
        
        return nil
    }

    // Finds sale based on menuItem id
    func getCurrentSale(with menuItem: (any MenuItemProtocol)) -> Sale? {
        return sales.first { sale in
            sale.menuItemsID?.contains(menuItem.id) ?? false
        }
    }
    
    // Checks availability of sale.
    func checkAvailablilaty(with sale: Sale, coordinator: MainCoordinator?) -> Bool {
        
        // If sale item already added to basket
        // Makes unavailable "add to basket" button
        if let coordinator = coordinator {
            return !coordinator.availabilityValidator.unavailableItems.contains(sale.id)
        }
        
       return false
    }
    
}
