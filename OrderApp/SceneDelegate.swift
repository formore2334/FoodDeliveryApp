//
//  SceneDelegate.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit


// Tracks loading error
protocol DataDelegate: AnyObject {
    func didReceiveValidData()
    func didReceiveInvalidData()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate, DataDelegate {
    
    var coordinator: Coordinator?
    var window: UIWindow?
    var tabBarController: UITabBarController?
    var errorScreenViewController: ErrorScreenViewController?
    var errorManager = ErrorManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        errorManager.dataDelegate = self
        
        if errorManager.error != nil {
            self.setErrorScreenViewController(to: window)
        } else {
            self.setTabBarController(to: window)
        }
        
    }
    
    
    func didReceiveValidData() {
        guard let window = window else { return }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.setTabBarController(to: window)
        }, completion: nil)
        
    }
    
    func didReceiveInvalidData() {
        guard let window = window else { return }
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.setErrorScreenViewController(to: window)
        }, completion: nil)
        
    }
    
    // Load main screen
    private func setTabBarController(to window: UIWindow) {
        if let tabBarController = self.tabBarController {
            self.coordinator = MainCoordinator(tabBarController: tabBarController)
            self.coordinator?.start()
            window.rootViewController = tabBarController
        } else {
            let tabBarController = UITabBarController()
            self.tabBarController = tabBarController
            self.coordinator = MainCoordinator(tabBarController: tabBarController)
            self.coordinator?.start()
            window.rootViewController = tabBarController
        }
        self.errorScreenViewController = nil
        
        setWindow(window)
    }
    
    // Load error screen
    private func setErrorScreenViewController(to window: UIWindow) {
        
        if let errorScreenViewController = self.errorScreenViewController {
            window.rootViewController = errorScreenViewController
        } else {
            let errorScreenViewController = ErrorScreenViewController()
            self.errorScreenViewController = errorScreenViewController
            window.rootViewController = errorScreenViewController
        }
        self.tabBarController = nil
        
        setWindow(window)
    }
    
    // Makes main window visible
    private func setWindow(_ window: UIWindow) {
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
    }

//        let window = UIWindow(windowScene: windowScene)
//
//
//        let tabBarController = UITabBarController()
//        coordinator = MainCoordinator(tabBarController: tabBarController)
//        coordinator?.start()
//
////        let vc = PayViewController(userInfo: UserInfo(orderNumber: "", name: "Mike", phone: "123456789", email: "heloeverybodyimfine@gmail.com", address: "st. St. Patrick, b.74, 221", comment: "", coupon: ""), basket: Basket(basketItems: []))
//
//        let vc = ErrorScreenViewController()
//
//        //let vc = CheckoutListViewController(basket: Basket(basketItems: Basket.mockData.basketItems))
//        let navVC = UINavigationController(rootViewController: vc)
//
//        window.rootViewController = navVC
//        window.backgroundColor = .white
//        window.makeKeyAndVisible()
//        self.window = window
//    }

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

