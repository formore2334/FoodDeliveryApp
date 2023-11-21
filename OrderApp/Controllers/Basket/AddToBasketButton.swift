//
//  AddToBascketButton.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit


class AddToBasketButton: UIView {
    
    var coordinator: MainCoordinator?
    
    var menuItem: MenuItem?

    private var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to bascket", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 400, height: 60)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addButton)
        configureAddButton()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAddButton() {
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        guard let menuItem = menuItem else { return }
        addButton.setTitle("\(menuItem.title) added", for: .normal)
        coordinator?.passOrderToBasket(menuItem: menuItem)
    }
    
    private func setConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
