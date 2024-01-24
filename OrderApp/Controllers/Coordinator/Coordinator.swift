//
//  Coordinator.swift
//  OrderApp
//
//  Created by ForMore on 02/11/2023.
//

import UIKit

protocol Coordinator {
    var tabBarController: UITabBarController { get set }

    func start()
}

protocol Coordinating {
    var coordinator: MainCoordinator? { get set }
}
