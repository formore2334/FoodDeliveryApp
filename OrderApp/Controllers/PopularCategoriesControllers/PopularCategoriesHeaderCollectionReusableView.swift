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
    
    
  public func configure() {
        self.addSubview(titleLabel)
        titleLabel.text = "Most popular at this week"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.adjustsFontSizeToFitWidth = true

        setConstraints()
    }
    
    //MARK: - Constraints
    
   private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),

            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -210)
        ])
    }
   
}
