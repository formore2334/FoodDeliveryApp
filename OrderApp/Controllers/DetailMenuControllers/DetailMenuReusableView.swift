//
//  DetailMenuReusableView.swift
//  OrderApp
//
//  Created by ForMore on 20/10/2023.
//

import UIKit

class DetailMenuReusableView: UICollectionReusableView {
    
    private var titleLabel = UILabel()
    
    static let idintifier = "DetailMenuReusableView"
    
    public func configure(title: String) {
        self.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        setConstraints()
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: bounds.size.width)
        ])
    }
    
}
