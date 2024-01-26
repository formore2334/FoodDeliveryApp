//
//  MainCoordinator.swift
//  OrderApp
//
//  Created by ForMore on 02/11/2023.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var tabBarController: UITabBarController
    
    private let container = CustomTabBarContainer()
    
    var availabilityValidator = AvailabilityValidator()
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        print("TabBar init")
    }
    
    deinit {
    print("TabBar deinit")
    }
    
    func start() {
        let homeVC = HomeViewController()
        let menuVC = MenuCollectionViewController()
        let basketVC = BasketViewController()
       
        homeVC.coordinator = self
        menuVC.coordinator = self
        basketVC.coordinator = self
        
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        let menuNavigationController = UINavigationController(rootViewController: menuVC)
        let basketNavigationController = UINavigationController(rootViewController: basketVC)
        
        tabBarController.viewControllers = [homeNavigationController, menuNavigationController, basketNavigationController]
        tabBarController.tabBar.tintColor = .black
        
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        menuNavigationController.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "fork.knife"), tag: 1)
        basketNavigationController.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "basket"), tag: 2)
    }
    
    // Sets basket item counter
    func configureTabBarLabel(with count: Int) {
        tabBarController.tabBar.addSubview(container)
        tabBarController.tabBar.sendSubviewToBack(container)
        
        container.configureLabel(with: count)
        
        // Finds basketView inside tabBarController
        // And pin label to it with value "view"
        if let basketTabBarItem = tabBarController.tabBar.items?[2],
           let basketView = basketTabBarItem.value(forKey: "view") as? UIView {
            container.pinToBounds(to: basketView)
        }
        
    }
    
// MARK: - Transfering data between view's
    
    // Sends regular menuItem to basket
    func passOrderToBasket(menuItem: (any MenuItemProtocol)) {
        
        // Finds a basket nav controller in an tab bar controller array
        if let basketNavigationController = tabBarController.viewControllers?[2] as? UINavigationController,
           
            // Creates basketVC from the found controller
           let basketVC = basketNavigationController.viewControllers.first as? BasketViewController {
            
            // Pass data to vc
            basketVC.addItemToBasket(menuItem: menuItem)
        }
        
    }
    
    // Sends array of special menuItem's to basket
    func passSpecialOrderToBasket(with specialMenuItems: [SpecialMenuItem], saleID: Int, discountTitle: String) {
        
        // Finds a basket nav controller in an tab bar controller array
        if let basketNavigationController = tabBarController.viewControllers?[2] as? UINavigationController,
           
            // Creates basketVC from the found controller
           let basketVC = basketNavigationController.viewControllers.first as? BasketViewController {
            
            // Pass another data to vc
            basketVC.addSpecialItemToBasket(with: specialMenuItems, saleID: saleID, discountTitle: discountTitle)
        }
        
    }
    
    // Goes to desired sale view controller
    func goToCurrentSale(menuItem: (any MenuItemProtocol)) {
        let salesManager = SalesManager()
        
        // Checks sale for availability
        guard let sale = salesManager.getCurrentSale(with: menuItem) else {
            print("Sale not found")
            return
        }
        
        let saleInfoVC = SaleInfoViewController(sale: sale, salesManager: salesManager, coordinator: self)
        
        // Creates new nav controller & open detailSaleVC
        let navigationController = tabBarController.selectedViewController as? UINavigationController
        navigationController?.pushViewController(saleInfoVC, animated: true)
    }
    
    
}
