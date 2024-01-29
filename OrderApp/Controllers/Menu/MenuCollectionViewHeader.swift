//
//  MenuHeaderView.swift
//  OrderApp
//
//  Created by ForMore on 14/11/2023.
//

import UIKit

final class MenuCollectionViewHeader: UICollectionReusableView {
    
    static let identifier = "MenuHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
        ])
    }
    
}
