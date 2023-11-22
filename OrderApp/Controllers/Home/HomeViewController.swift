//
//  HomeViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    var coordinator: MainCoordinator?
    
    private var scrollView = UIScrollView()
    
    private var popularCategoriesStackView = UIStackView()
    
    private var salesCategoriesStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureLogo()
        configureScrollView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
        
        popularCategoriesStackView.frame = CGRect(x: 0, y: 20, width: view.bounds.width, height: 200)
        popularCategoriesStackView.axis = .horizontal
        
        salesCategoriesStackView.frame = CGRect(x: 0, y: 270, width: view.bounds.width, height: 250)
        salesCategoriesStackView.axis = .horizontal
    }
    
    // MARK: - Configurations
    
    func configureLogo() {
        guard let navigationController = navigationController else { return }
        
        let logoView = LogoView()
        logoView.setupNavigationBarLogo(in: navigationController, with: navigationItem)
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(popularCategoriesStackView)
        scrollView.addSubview(salesCategoriesStackView)
        
        addPopularCategoriesToStackView()
        addSalesToStackView()
        
        setScrollViewConstraints()
    }
    
    //MARK: - Adding collections to stackView
    
    func addPopularCategoriesToStackView() {
        let popularCategoriesVC = PopularCategoriesViewController(coordinator: coordinator)
        
        addChild(popularCategoriesVC)
        
        popularCategoriesStackView.addArrangedSubview(popularCategoriesVC.view)
        
        popularCategoriesVC.didMove(toParent: self)
    }
    
    func addSalesToStackView() {
        let salesVC = SaleViewController(coordinator: coordinator)
        
        addChild(salesVC)
        
        salesCategoriesStackView.addArrangedSubview(salesVC.view)
        
        salesVC.didMove(toParent: self)
    }
    
    // MARK: - Constraints
    
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
