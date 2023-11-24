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
    
    private var couponsCategoriesStackView = UIStackView()
    
    private var lastPresentedViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureLogo()
        configureScrollView()
        didAppearTranslationAnimation()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 770)
        
        popularCategoriesStackView.frame = CGRect(x: 0, y: 20, width: view.bounds.width, height: 200)
        popularCategoriesStackView.axis = .horizontal
        
        salesCategoriesStackView.frame = CGRect(x: 0, y: 265, width: view.bounds.width, height: 250)
        salesCategoriesStackView.axis = .horizontal
        
        couponsCategoriesStackView.frame = CGRect(x: 0, y: 540, width: view.bounds.width, height: 230)
        couponsCategoriesStackView.axis = .horizontal
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
        scrollView.addSubview(couponsCategoriesStackView)
        
        addPopularCategoriesToStackView()
        addSalesToStackView()
        addCouponsToStackView()
        
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
    
    func addCouponsToStackView() {
        let couponsVC = CouponViewController()
        
        addChild(couponsVC)
        
        couponsCategoriesStackView.addArrangedSubview(couponsVC.view)
        
        couponsVC.didMove(toParent: self)
    }
    
    // Animate appear
    func didAppearTranslationAnimation() {
        CGAffineTransform.animateContentFlyIn(middleItem: salesCategoriesStackView, firstItem: popularCategoriesStackView, lastItem: couponsCategoriesStackView, superView: view)
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
