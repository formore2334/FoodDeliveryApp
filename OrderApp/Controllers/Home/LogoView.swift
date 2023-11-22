//
//  LogoView.swift
//  OrderApp
//
//  Created by ForMore on 21/11/2023.
//

import UIKit


class LogoView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoWelms")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavigationBarLogo(in navigationController: UINavigationController, with navigationItem: UINavigationItem) {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0,
                                                 width: navigationController.navigationBar.bounds.width / 2,
                                                 height: navigationController.navigationBar.bounds.height))
        
        logoContainer.addSubview(logoImageView)
        logoImageView.frame = CGRect(x: logoContainer.center.x / 2, y: 0,
                                     width: navigationController.navigationBar.bounds.width / 4,
                                     height: navigationController.navigationBar.bounds.height * 0.8)
        
        navigationItem.titleView = logoContainer
    }

}
