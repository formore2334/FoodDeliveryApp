//
//  HomeViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    private var scrollView = UIScrollView()
    
    private var popularCategoriesStackView = UIStackView()
    
    private var salesCategoriesStackView = UIStackView()
    
    private let logoImageView = UIImageView()
    
    private let logoContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogoImage()
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
    
    
    func configureLogoImage() {
        logoImageView.image = UIImage(named: "logoWelms")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.layer.masksToBounds = true
        logoImageView.backgroundColor = .systemGray6
        
        view.addSubview(logoContainer)
        logoContainer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 7)
        logoContainer.backgroundColor = .systemGray6
        logoContainer.addSubview(logoImageView)
        
        setLogoImageConstraints()
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
    
    func setLogoImageConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 60),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: logoContainer.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
