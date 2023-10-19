//
//  SaleCollectionReusableView.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class SaleCollectionReusableView: UICollectionReusableView {
    
    private var titleLabel = UILabel()

    static let idintifier = "SaleCollectionReusableView"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
    }
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.text = "Sales"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.adjustsFontSizeToFitWidth = true

    }
  
}
