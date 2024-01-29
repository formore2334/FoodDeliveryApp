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
    
    private let quickMenuStackView = UIStackView()
    
    private let salesStackView = UIStackView()
    
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
        logoView.configureIntoNavBar(in: navigationController, with: navigationItem)
    }
    
    // Sets an animation of the first entry to the screen
    @objc private func didAppearTranslationAnimation() {
        CGAffineTransform.animateContentFlyIn(middleItem: salesStackView, firstItem: quickMenuStackView, lastItem: couponsCategoriesStackView, superView: view)
    }
    
    //MARK: - Adds all collections to view
    
    // Sets scrollView with all stackView's
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.alwaysBounceVertical = true
        
        scrollView.addSubview(masterStackView)
        
        masterStackView.addArrangedSubview(quickMenuStackView)
        masterStackView.addArrangedSubview(salesStackView)
        masterStackView.addArrangedSubview(couponsCategoriesStackView)
        
        addQuickMenuToStackView()
        addSalesToStackView()
        addCouponsToStackView()
        
        setScrollViewConstraints()
        setStackViewConstraints()
    }
    
    private func addQuickMenuToStackView() {
        let quickMenuVC = QuickMenuCollectionViewController(coordinator: coordinator)
        
        addChild(quickMenuVC)
        
        quickMenuStackView.addArrangedSubview(quickMenuVC.view)
        
        quickMenuVC.didMove(toParent: self)
    }
    
    private func addSalesToStackView() {
        let saleVC = SaleCollectionViewController(coordinator: coordinator)
        
        addChild(saleVC)
        
        salesStackView.addArrangedSubview(saleVC.view)
        
        saleVC.didMove(toParent: self)
    }
    
    private func addCouponsToStackView() {
        let couponsVC = CouponCollectionViewController()
        
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
        quickMenuStackView.translatesAutoresizingMaskIntoConstraints = false
        salesStackView.translatesAutoresizingMaskIntoConstraints = false
        couponsCategoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            masterStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            masterStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            masterStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            masterStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            masterStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            quickMenuStackView.widthAnchor.constraint(equalTo: masterStackView.widthAnchor),
            quickMenuStackView.heightAnchor.constraint(equalToConstant: 200),
            
            salesStackView.widthAnchor.constraint(equalTo: masterStackView.widthAnchor),
            salesStackView.heightAnchor.constraint(equalToConstant: 250),
            
            couponsCategoriesStackView.widthAnchor.constraint(equalTo: masterStackView.widthAnchor),
            couponsCategoriesStackView.heightAnchor.constraint(equalToConstant: 230),
        ])
        
    }
    
}
