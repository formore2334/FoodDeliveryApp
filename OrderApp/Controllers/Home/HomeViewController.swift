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
    
    private var masterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 50
        return stackView
    }()
    
    private var popularCategoriesStackView = UIStackView()
    
    private var salesCategoriesStackView = UIStackView()
    
    private var couponsCategoriesStackView = UIStackView()
    
    private var lastPresentedViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didAppearTranslationAnimation),
                                               name: NSNotification.Name("BackToHomeNotification"),
                                               object: nil)
        
        configureLogo()
        configureScrollView()
        didAppearTranslationAnimation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configurations
    
    func configureLogo() {
        guard let navigationController = navigationController else { return }
        
        let logoView = LogoView()
        logoView.setupNavigationBarLogo(in: navigationController, with: navigationItem)
    }
    
    func configureScrollView() {
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
    
    func addCouponsToStackView() {
        let couponsVC = CouponViewController()
        
        addChild(couponsVC)
        
        couponsCategoriesStackView.addArrangedSubview(couponsVC.view)
        
        couponsVC.didMove(toParent: self)
    }
    
    // Animate appear
    @objc func didAppearTranslationAnimation() {
        CGAffineTransform.animateContentFlyIn(middleItem: salesCategoriesStackView, firstItem: popularCategoriesStackView, lastItem: couponsCategoriesStackView, superView: view)
    }

    // MARK: - Constraints
    
    private func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    // Set constraints to each stack view
    private func setStackViewConstraints() {
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
