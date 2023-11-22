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
        
        // Embed controllers in a UINavigationController. Its doing to appear logoImage
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let menuNavVC = UINavigationController(rootViewController: menuVC)
        //let basketNavVC = UINavigationController(rootViewController: basketVC)
        navigationController.isNavigationBarHidden = true
        
        tabBarController.viewControllers = [homeNavVC, menuNavVC, basketVC]
        tabBarController.tabBar.tintColor = .black
        
        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        menuNavVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "fork.knife"), tag: 1)
        basketVC.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "basket"), tag: 2)
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
        
    

    
    func passOrderToBasket(menuItem: MenuItem) {
        if let basketVC = tabBarController.viewControllers?[2] as? BasketViewController {
            basketVC.addItemToBasket(menuItem: menuItem)
        }
    }

}
