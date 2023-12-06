//
//  SalesManager.swift
//  OrderApp
//
//  Created by ForMore on 30/11/2023.
//

import Foundation


struct SalesManager {

    private let menu: [Menu] = Menu.mockData
    
    let sales: [Sale] = Sale.mockData
    
    var menuItems: [MenuItem] = []
    
    mutating func extractMenuItems() {
        let menuItems = self.menu.flatMap { $0.menuItem }
        
        self.menuItems = menuItems
    }
    
    func getCurrentSale(with menuItem: MenuItem) -> Sale? {
        return sales.first { $0.menuItems?.contains(menuItem) ?? false}
    }
    
}
