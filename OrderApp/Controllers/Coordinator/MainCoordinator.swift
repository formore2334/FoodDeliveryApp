//
//  MainCoordinator.swift
//  OrderApp
//
//  Created by ForMore on 02/11/2023.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
   private let tabBarController = UITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeViewController()
        let menuVC = MenuViewController()
        let basketVC = BasketViewController()
       
        homeVC.coordinator = self
        menuVC.coordinator = self
        basketVC.coordinator = self
        
        tabBarController.viewControllers = [homeVC, menuVC, basketVC]
        tabBarController.tabBar.tintColor = .black
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        menuVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "fork.knife"), tag: 1)
        basketVC.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "basket"), tag: 2)
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    func passOrderToBasket(menuItem: MenuItem) {
        if let basketVC = tabBarController.viewControllers?[2] as? BasketViewController {
            basketVC.addItemToBasket(menuItem: menuItem)
        }
    }

}
