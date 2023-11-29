//
//  SceneDelegate.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: Coordinator?
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

        
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        
        let vc = CheckoutListViewController(basket: Basket(basketItems: []))
        let navVC = UINavigationController(rootViewController: vc)

        window.rootViewController = navController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
        
//        let homeVC = HomeViewController()
//        let menuVC = MenuViewController()
//        let basketVC = BasketViewController()
//
//        let homeNC = UINavigationController(rootViewController: homeVC)
//        let menuNC = UINavigationController(rootViewController: menuVC)
//        let basketNC = UINavigationController(rootViewController: basketVC)
//
//        let tabBar = UITabBarController()
//        tabBar.setViewControllers([homeNC, menuNC, basketNC], animated: true)
//
//        tabBar.tabBar.backgroundImage = UIImage()
//        tabBar.tabBar.shadowImage = UIImage()
//        tabBar.tabBar.tintColor = .black
//
//        homeNC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
//        menuNC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "fork.knife"), tag: 2)
//        basketNC.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "basket"), tag: 3)
//
//        window.rootViewController = tabBar
//        window.backgroundColor = .white
//        self.window = window
//        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

