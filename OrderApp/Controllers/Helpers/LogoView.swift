//
//  LogoView.swift
//  OrderApp
//
//  Created by ForMore on 21/11/2023.
//

import UIKit


final class LogoView: UIView {
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoWelms")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    func configureIntoNavBar(in navigationController: UINavigationController, with navigationItem: UINavigationItem) {
        
        // Config container for logo
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0,
                                                 width: navigationController.navigationBar.bounds.width / 2,
                                                 height: navigationController.navigationBar.bounds.height))
        
        logoContainer.addSubview(logoImageView)
        
        // Config logo inside container
        logoImageView.frame = CGRect(x: logoContainer.center.x / 2, y: 0,
                                     width: navigationController.navigationBar.bounds.width / 4,
                                     height: navigationController.navigationBar.bounds.height * 0.8)
        
        // Sets logo as titleView in nav bar pannel
        navigationItem.titleView = logoContainer
    }

}
