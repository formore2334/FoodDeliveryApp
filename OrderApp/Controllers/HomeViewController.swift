//
//  HomeViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome!"
        
        let popularCategoriesVC = PopularCategoriesViewController()
        let saleVC = SaleViewController()
            
        addChild(popularCategoriesVC)
           view.addSubview(popularCategoriesVC.view)
           popularCategoriesVC.didMove(toParent: self)
           
           addChild(saleVC)
           view.addSubview(saleVC.view)
           saleVC.didMove(toParent: self)

        popularCategoriesVC.view.translatesAutoresizingMaskIntoConstraints = false
        saleVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            popularCategoriesVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            popularCategoriesVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularCategoriesVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularCategoriesVC.view.heightAnchor.constraint(equalToConstant: 100),
            
            saleVC.view.topAnchor.constraint(equalTo: popularCategoriesVC.view.bottomAnchor, constant: 100),
            saleVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            saleVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            saleVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])


    }
    

}
