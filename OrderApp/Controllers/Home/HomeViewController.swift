//
//  HomeViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate, Coordinating {
    
    var coordinator: MainCoordinator?
    
    //MARK: - Set variables
    
    private let scrollView = UIScrollView()
    
    private let popularCategoriesStackView = UIStackView()
    
    private let salesCategoriesStackView = UIStackView()
    
    private let couponsCategoriesStackView = UIStackView()
    
    // Stack view for each other stack view in this vc
    private var masterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 50
        return stackView
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Listens to notification from last page (when user returns from final pay page)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didAppearTranslationAnimation),
                                               name: .backToHome,
                                               object: nil)
        
        configureLogo()
        configureScrollView()
        didAppearTranslationAnimation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configurations
    
    // Sets logo to nav bar pannel
    private func configureLogo() {
        guard let navigationController = navigationController else { return }
        
        let logoView = LogoView()
        logoView.setupNavigationBarLogo(in: navigationController, with: navigationItem)
    }
    
    // Sets an animation of the first entry to the screen
    @objc private func didAppearTranslationAnimation() {
        CGAffineTransform.animateContentFlyIn(middleItem: salesCategoriesStackView, firstItem: popularCategoriesStackView, lastItem: couponsCategoriesStackView, superView: view)
    }
    
    //MARK: - Adds all collections to view
    
    // Sets scrollView with all stackView's
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.alwaysBounceVertical = true
        
        scrollView.addSubview(masterStackView)
        
        masterStackView.addArrangedSubview(popularCategoriesStackView)
        masterStackView.addArrangedSubview(salesCategoriesStackView)
        masterStackView.addArrangedSubview(couponsCategoriesStackView)
        
        addPopularCategoriesToStackView()
        addSalesToStackView()
        addCouponsToStackView()
        
        setScrollViewConstraints()
        setStackViewConstraints()
    }
    
    private func addPopularCategoriesToStackView() {
        let popularCategoriesVC = PopularCategoriesViewController(coordinator: coordinator)
        
        addChild(popularCategoriesVC)
        
        popularCategoriesStackView.addArrangedSubview(popularCategoriesVC.view)
        
        popularCategoriesVC.didMove(toParent: self)
    }
    
    private func addSalesToStackView() {
        let salesVC = SaleViewController(coordinator: coordinator)
        
        addChild(salesVC)
        
        salesCategoriesStackView.addArrangedSubview(salesVC.view)
        
        salesVC.didMove(toParent: self)
    }
    
    private func addCouponsToStackView() {
        let couponsVC = CouponViewController()
        
        addChild(couponsVC)
        
        couponsCategoriesStackView.addArrangedSubview(couponsVC.view)
        
        couponsVC.didMove(toParent: self)
    }
    
}

// MARK: - Constraints

private extension HomeViewController {
    
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    // Sets constraints to each stack view
    func setStackViewConstraints() {
        masterStackView.translatesAutoresizingMaskIntoConstraints = false
        popularCategoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        salesCategoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        couponsCategoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            masterStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            masterStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            masterStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            masterStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            masterStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            popularCategoriesStackView.widthAnchor.constraint(equalTo: masterStackView.widthAnchor),
            popularCategoriesStackView.heightAnchor.constraint(equalToConstant: 200),
            
            salesCategoriesStackView.widthAnchor.constraint(equalTo: masterStackView.widthAnchor),
            salesCategoriesStackView.heightAnchor.constraint(equalToConstant: 250),
            
            couponsCategoriesStackView.widthAnchor.constraint(equalTo: masterStackView.widthAnchor),
            couponsCategoriesStackView.heightAnchor.constraint(equalToConstant: 230),
        ])
        
    }
    
}
