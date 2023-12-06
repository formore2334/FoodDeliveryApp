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
            heightAnchor.constraint(equalToConstant: 40.0),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 50),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -50),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])

    }
    
    func pinPayBtn(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 60),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -60),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    func pinToBounds(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
               topAnchor.constraint(equalTo: superView.topAnchor),
               bottomAnchor.constraint(equalTo: superView.bottomAnchor),
               leadingAnchor.constraint(equalTo: superView.leadingAnchor),
               trailingAnchor.constraint(equalTo: superView.trailingAnchor)
           ])
    }
    
}
