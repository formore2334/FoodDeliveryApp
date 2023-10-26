//
//  UIView+Extansions.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit


extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


extension UIView {
    
    func pin(superView: UIView, top: CGFloat, leading: CGFloat, trailing: CGFloat, bottom: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: trailing),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: bottom)
        ])
    }
    
}
