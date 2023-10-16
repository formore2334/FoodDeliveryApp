//
//  HeaderCollectionReusableView.swift
//  OrderApp
//
//  Created by ForMore on 14/10/2023.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    private var titleLabel = UILabel()
    
    static let idintifier = "HeaderCollectionReusableView"
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        titleLabel.frame = bounds
//    }
    
    func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = "Menu"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textAlignment = .left
        //titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        
        setTitleLabelConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        
    }
}
