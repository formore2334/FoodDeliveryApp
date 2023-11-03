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
    
    public func configure() {
          self.addSubview(titleLabel)
          titleLabel.text = "Sales"
          titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
          titleLabel.adjustsFontSizeToFitWidth = true

          setConstraints()
      }
      
      //MARK: - Constraints
      
     private func setConstraints() {
          titleLabel.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
              titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
          ])
      }
  
}
