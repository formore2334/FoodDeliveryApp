//
//  HomeViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var titleLabel = UILabel()
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitleLabel()
        configureStackView()
        
    }
    
    
    //MARK: - StackView
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        addCollectionsToStackView()
        setStackViewConstraints()
    }
    
    func addCollectionsToStackView() {
        let popularCategoriesVC = PopularCategoriesViewController()
        let saleVC = SaleViewController()
        
        addChild(popularCategoriesVC)
        addChild(saleVC)
        
        stackView.addArrangedSubview(popularCategoriesVC.view)
        stackView.addArrangedSubview(saleVC.view)
        
        popularCategoriesVC.didMove(toParent: self)
        saleVC.didMove(toParent: self)
    }
    
    
    //MARK: - Title
    
    func configureTitleLabel() {
        
        view.addSubview(titleLabel)
        titleLabel.text = "Welm's"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 90)
        titleLabel.backgroundColor = UIColor(named: "redOrange")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
    
    }
    
    
    // MARK: - Constraints
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
}
