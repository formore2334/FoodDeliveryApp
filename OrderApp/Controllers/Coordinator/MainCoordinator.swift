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
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        print("TabBar init")
    }
    
    deinit {
    print("TabBar deinit")
    }
    
    func start() {
        let homeVC = HomeViewController()
        let menuVC = MenuViewController()
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
    
    
    func configureTabBarLabel(with count: Int) {
        tabBarController.tabBar.addSubview(container)
        tabBarController.tabBar.sendSubviewToBack(container)
        
        container.configureLabel(with: count)
        
        if let basketTabBarItem = tabBarController.tabBar.items?[2],
           let basketView = basketTabBarItem.value(forKey: "view") as? UIView {
            container.pinToBounds(to: basketView)
        }
        
    }
    
    
    func passOrderToBasket(menuItem: (any MenuItemProtocol)) {
        if let basketNavigationController = tabBarController.viewControllers?[2] as? UINavigationController,
           let basketVC = basketNavigationController.viewControllers.first as? BasketViewController {
            basketVC.addItemToBasket(menuItem: menuItem)
        }
    }
    
    func goToCurrentSale(menuItem: (any MenuItemProtocol)) {
        let salesManager = SalesManager()
        
        guard let sale = salesManager.getCurrentSale(with: menuItem) else {
            print("Sale not found")
            return
        }
        
        let detailSaleVC = DetailSaleViewController(sale: sale, salesManager: salesManager, coordinator: self)
        
        let navigationController = tabBarController.selectedViewController as? UINavigationController
        navigationController?.pushViewController(detailSaleVC, animated: true)
    }
    
    
}
