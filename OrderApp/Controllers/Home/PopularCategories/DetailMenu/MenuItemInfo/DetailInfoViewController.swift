//
//  DetailInfoCollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import UIKit


// MARK: - Detail info about selected item from menu

class DetailInfoViewController: UIViewController {
    
    var menuItem: (any MenuItemProtocol)
    
    var menuTitle: String
    
    var coordinator: MainCoordinator?
    
    private let networkManager = NetworkManager()
    
    private let customButton = CustomButton()
    
    private let specialSaleButton = SpecialSaleButton()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private var contentView = UIView()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .darkGray
        textView.isEditable = false
        textView.font = UIFont.preferredFont(forTextStyle: .footnote)
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 10
        return textView
    }()

    init(menuItem: (any MenuItemProtocol), menuTitle: String, coordinator: MainCoordinator? = nil) {
        self.menuItem = menuItem
        self.menuTitle = menuTitle
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        title = menuTitle
        view.backgroundColor = .white
        
        specialSaleButton.startPulsatingAnimation()
    }
   

    
    // MARK: - Configure DetailInfo VC
    
    private func configureVC() {
        prepareVC()
        setCustomButton()
        setSpecialSaleButton()
        
        setAllConstraints()
    }
    
    // MARK: - Configure varibles
    
    private func prepareVC() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(textView)
        
        titleLabel.text = menuItem.title.uppercased()
        textView.text = menuItem.description
        
        getImage()
    }
    
    // Fetch image
    private func getImage() {
        guard let url = URL(string: menuItem.imageURL) else { return }
        
        networkManager.fetchImage(url: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    //MARK: - Constraints
    
    private func setAllConstraints() {
        setScrollViewConstraints()
        setImageViewConstraints()
        setTitleLabelConstrains()
        setTextViewConstrains()
    }
    
    // Scroll view & content view constraints
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setTitleLabelConstrains() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setTextViewConstrains() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
        ])
    }
    
    private func setSpecialSaleButtonConstraints() {
        specialSaleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            specialSaleButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            specialSaleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            specialSaleButton.heightAnchor.constraint(equalToConstant: 35),
            specialSaleButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}


// MARK: - Buttons Logic

extension DetailInfoViewController {
    
    // Basket Button translation
    private func setCustomButton() {
        view.addSubview(customButton)
        
        // Add sale string to button label if needs
        if let discountMenuItem = menuItem as? DiscountMenuItem {
            let priceString = "Add for \(discountMenuItem.newPrice)$"
            let crossedOldPriceString = " \(menuItem.price)"
            
            let attributedString = NSAttributedString()
            let prepareAttributedString = attributedString.concatenationWithCrossOut(baseString: priceString, crossedString: crossedOldPriceString)
            
            customButton.setAttributedTitle(prepareAttributedString, for: .normal)
        } else {
            customButton.setTitle("Add for \(menuItem.price)$", for: .normal)
        }
        
        customButton.pin(to: view)
        addActionToCustomButton()
    }
    
    private func addActionToCustomButton() {
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
    }
    
    @objc private func customButtonTapped() {
        customButton.setAttributedTitle(nil, for: .normal)
        customButton.setTitle("\(menuItem.title) added", for: .normal)
        customButton.pressWithEnable()
        coordinator?.passOrderToBasket(menuItem: menuItem)
    }
    
    
    // Special Button translation
    private func setSpecialSaleButton() {
        view.addSubview(specialSaleButton)
        
        // Add special sale button if needs
        if menuItem as? SpecialMenuItem != nil {
            addActionToSpecialSaleButton()
            setSpecialSaleButtonConstraints()
        }
    }
    
    private func addActionToSpecialSaleButton() {
        specialSaleButton.addTarget(self, action: #selector(specialSaleButtonTapped), for: .touchUpInside)
    }
    
    @objc private func specialSaleButtonTapped() {
        coordinator?.goToCurrentSale(menuItem: menuItem)
        specialSaleButton.stopPulsatingAnimation()
    }
    
}
