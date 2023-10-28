//
//  DetailInfoCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import UIKit


// MARK: - Detail info about selected item from menu

class DetailInfoViewController: UIViewController {
    
    var menuItem: MenuItem
    
    private var imageView = UIImageView()
    
    private var titleLabel = UILabel()
    
    private var textView = UITextView()
    
    private let addToBasketButton = AddToBascketButton()
    
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }
    
    
    // MARK: - Configure DetailInfo VC
    
    private func configureVC() {
        setImageView()
        setTitleLabel()
        setTextView()
        setAddButton()
        
        setAllConstraints()
    }
    
    // MARK: - Configure varibles
    
    private func setImageView() {
        view.addSubview(imageView)
        imageView.image = UIImage(named: menuItem.imageName)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height / 2.2)
    }
    
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = menuItem.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setTextView() {
        view.addSubview(textView)
        textView.text = menuItem.description
        textView.textColor = .systemGray
        textView.isEditable = false
        textView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height / 4)
    }
    
    private func setAddButton() {
        view.addSubview(addToBasketButton)
        addToBasketButton.delegate = self
        addToBasketButton.menuItem = menuItem
    }
    
    
    //MARK: - Constraints
    
    private func setAllConstraints() {
        setTitleLabelConstrains()
        setTextViewConstrains()
        setAddButtonConstraints()
    }
    
    private func setTitleLabelConstrains() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    private func setTextViewConstrains() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func setAddButtonConstraints() {
        addToBasketButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addToBasketButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            addToBasketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            addToBasketButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
}

//MARK: - Delegate
extension DetailInfoViewController: AddToBascketButtonDelegate {
    
    func didTapAddToBasketButton(with menuItem: MenuItem) {
        let basketVC = BasketViewController()
        basketVC.updateBasket(with: menuItem)
        navigationController?.pushViewController(basketVC, animated: true)
    }
    
}
