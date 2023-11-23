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
    
    var coordinator: MainCoordinator?
    
    private let networkManager = NetworkManager()
    
    private var menuItemImageView = UIImageView()
    
    private var menuItemTitleLabel = UILabel()
    
    private var menuItemDescriptionTextView = UITextView()
    
    private var menuItemIngredientsTextLabel = UILabel()
    
    private let customButton = CustomButton()

    init(menuItem: MenuItem, coordinator: MainCoordinator? = nil) {
        self.menuItem = menuItem
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    // MARK: - Configure DetailInfo VC
    
    private func configureVC() {
        setImageView()
        setTitleLabel()
        setTextView()
        setCustomButton()
        
        setAllConstraints()
    }
    
    // MARK: - Configure varibles
    
    private func setImageView() {
        view.addSubview(menuItemImageView)
        menuItemImageView.clipsToBounds = true
        menuItemImageView.contentMode = .scaleAspectFill
        menuItemImageView.layer.masksToBounds = true
        menuItemImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height / 2.2)
        
        getImage()
    }
    
    
    private func setTitleLabel() {
        view.addSubview(menuItemTitleLabel)
        menuItemTitleLabel.text = menuItem.title
        menuItemTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        menuItemTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setTextView() {
        view.addSubview(menuItemDescriptionTextView)
        menuItemDescriptionTextView.text = menuItem.description
        menuItemDescriptionTextView.textColor = .lightGray
        menuItemDescriptionTextView.isEditable = false
        menuItemDescriptionTextView.backgroundColor = .systemGray6
        menuItemDescriptionTextView.layer.cornerRadius = 10
    }
    
    private func getImage() {
        guard let url = URL(string: menuItem.imageURL) else { return }
        
        networkManager.fetchImage(url: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.menuItemImageView.image = image
            }
        }
    }
    
    //MARK: - Basket Button translation
    
    private func setCustomButton() {
        view.addSubview(customButton)
        customButton.setTitle("Add to basket", for: .normal)
        customButton.pin(to: view)
        addActionToCustomButton()
    }
    
    private func addActionToCustomButton() {
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
    }
    
    @objc private func customButtonTapped() {
        customButton.setTitle("\(menuItem.title) added", for: .normal)
        coordinator?.passOrderToBasket(menuItem: menuItem)
    }
    
    
    //MARK: - Constraints
    
    private func setAllConstraints() {
        setTitleLabelConstrains()
        setTextViewConstrains()
    }
    
    private func setTitleLabelConstrains() {
        menuItemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuItemTitleLabel.topAnchor.constraint(equalTo: menuItemImageView.bottomAnchor, constant: 20),
            menuItemTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            menuItemTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    private func setTextViewConstrains() {
        menuItemDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuItemDescriptionTextView.topAnchor.constraint(equalTo: menuItemTitleLabel.bottomAnchor, constant: 20),
            menuItemDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            menuItemDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            menuItemDescriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
    }
    
}

