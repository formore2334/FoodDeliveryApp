//
//  DetailSaleViewController.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import UIKit

class DetailSaleViewController: UIViewController {
    
    var sale: Sale
    
    var coordinator: MainCoordinator?
    
    private var saleTitleLabel = UILabel()
    
    private var saleDescriptionTextView = UITextView()

    private let customButton = CustomButton()

    init(sale: Sale, coordinator: MainCoordinator? = nil) {
        self.sale = sale
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
        navigationController?.navigationBar.tintColor = .black
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    // MARK: - Configure DetailInfo VC
    
    private func configureVC() {
        setTitleLabel()
        setTextView()
        setCustomButton()
        setBackgroundImage()
        
        setTextViewConstrains()
    }
    
    func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: sale.backgroundImageName))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.opacity = 0.5

        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        saleDescriptionTextView.addSubview(backgroundImageView)
        saleDescriptionTextView.sendSubviewToBack(backgroundImageView)

    }
    
    // MARK: - Configure varibles
    
    private func setTitleLabel() {
        view.addSubview(saleTitleLabel)
        saleTitleLabel.text = sale.title
        
        navigationItem.title = saleTitleLabel.text
    }
    
    private func setTextView() {
        view.addSubview(saleDescriptionTextView)
        saleDescriptionTextView.text = sale.description
        saleDescriptionTextView.textColor = .white
        saleDescriptionTextView.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        saleDescriptionTextView.isEditable = false
        //saleDescriptionTextView.backgroundColor = .systemGray6
        saleDescriptionTextView.layer.cornerRadius = 10
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
        customButton.pressWithEnable()
//        customButton.setTitle("\(menuItem.title) added", for: .normal)
//        coordinator?.passOrderToBasket(menuItem: menuItem)
    }
    
    
    //MARK: - Constraints
    
    private func setTextViewConstrains() {
        saleDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saleDescriptionTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            saleDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saleDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saleDescriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
    }
    
}
