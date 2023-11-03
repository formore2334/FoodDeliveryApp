//
//  Coordinator.swift
//  OrderApp
//
//  Created by ForMore on 02/11/2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    

    func start()
}
