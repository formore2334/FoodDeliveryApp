//
//  SalesManager.swift
//  OrderApp
//
//  Created by ForMore on 30/11/2023.
//

import Foundation


struct SalesManager {
    
    var sales: [Sale]
    
    var menu: [Menu] = DataService.shared.menu
    
    init(sales: [Sale] = DataService.shared.sales) {
        self.sales = sales
    }
    
    
    func getMenuItem(at id: Int) -> (any MenuItemProtocol)? {
        for menuCategory in menu {
            if let menuItem = menuCategory.menuItems.first(where: { $0.id == id }) {
                return menuItem
            }
        }
        return nil
    }

    
    func getCurrentSale(with menuItem: (any MenuItemProtocol)) -> Sale? {
        return sales.first { sale in
            sale.menuItemsID?.contains(menuItem.id) ?? false
        }
    }
    
}
