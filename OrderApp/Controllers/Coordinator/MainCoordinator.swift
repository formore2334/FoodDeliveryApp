//
//  MainCoordinator.swift
//  OrderApp
//
//  Created by ForMore on 02/11/2023.
//

import UIKit

class MainCoordinator: Coordinator {    
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let homeVC = HomeViewController()
        let menuVC = MenuViewController()
        let basketVC = BasketViewController()
       
        homeVC.coordinator = self
        menuVC.coordinator = self
        basketVC.coordinator = self
        
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let menuNavVC = UINavigationController(rootViewController: menuVC)
        let basketNavVC = UINavigationController(rootViewController: basketVC)
        
        tabBarController.viewControllers = [homeNavVC, menuNavVC, basketNavVC]
        tabBarController.tabBar.tintColor = .black
        
        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        menuNavVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "fork.knife"), tag: 1)
        basketNavVC.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "basket"), tag: 2)
    }
        
    
    func passOrderToBasket(menuItem: MenuItem) {
        if let basketNavVC = tabBarController.viewControllers?[2] as? UINavigationController,
           let basketVC = basketNavVC.viewControllers.first as? BasketViewController {
            basketVC.addItemToBasket(menuItem: menuItem)
        }
    }
    
    func goToCurrentSale(menuItem: MenuItem) {
        let saleManager = SalesManager()
        
        guard let sale = saleManager.getCurrentSale(with: menuItem) else {
            print("Sale not found")
            return
        }
        
        let detailSaleVC = DetailSaleViewController(sale: sale, coordinator: self)
        
        let navigationController = tabBarController.selectedViewController as? UINavigationController
        navigationController?.pushViewController(detailSaleVC, animated: true)
    }
    
}
