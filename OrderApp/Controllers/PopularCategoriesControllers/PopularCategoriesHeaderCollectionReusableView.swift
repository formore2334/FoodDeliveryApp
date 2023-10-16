//
//  HeaderCollectionReusableView.swift
//  OrderApp
//
//  Created by ForMore on 14/10/2023.
//

import UIKit

class PopularCategoriesHeaderCollectionReusableView: UICollectionReusableView {
        
    private var titleLabel = UILabel()

    static let idintifier = "HeaderCollectionReusableView"
    
    override func layoutSubviews() {
        super.layoutSubviews()
            titleLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
    }
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.text = "Menu"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        //setTitleLabelConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
