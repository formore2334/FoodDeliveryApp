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
    
    private let networkManager = NetworkManager()
    
    private var saleTitleLabel = UILabel()
    
    private lazy var dividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor.gray
        return dividerView
    }()
    
  //  private var dividerView = DividerView()
    
    private lazy var headlineTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .gray
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isEditable = false
        return textView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layer.cornerRadius = 30
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private let customButton = CustomButton()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.layer.opacity = 0.5
        return imageView
    }()
    
    var isValid: Bool {
        return sale.menuItems != nil
    }

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
        
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(popToRootVC),
                                               name: NSNotification.Name("BackToHomeNotification"),
                                               object: nil)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configure DetailInfo VC
    
    private func configureVC() {
        
        setTitleLabel()
        setScrollView()
        setCustomButton()
        setBackgroundImage()
    }
    
    func setBackgroundImage() {
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        getImage()
    }
    
    private func getImage() {
        guard let url = URL(string: sale.backgroundImageURL) else { return }
        
        networkManager.fetchImage(url: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.backgroundImageView.image = image
            }
        }
    }
    
    // Listening to notification
    @objc func popToRootVC() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    // MARK: - Configure varibles
    
    private func setTitleLabel() {
        view.addSubview(saleTitleLabel)
        saleTitleLabel.text = sale.title
        
        navigationItem.title = saleTitleLabel.text
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.bounds.width, height:
                                            headlineTextLabel.bounds.height + descriptionTextView.bounds.height)
        
        scrollView.addSubview(headlineTextLabel)
        scrollView.addSubview(descriptionTextView)
       
        setHeadlineTextLabel()
        setDivider()
        setTextView()
        
        setDividerViewConstraints()
        setScrollViewConstrains()
    }
    
    private func setHeadlineTextLabel() {
        view.addSubview(headlineTextLabel)
        headlineTextLabel.text = sale.textHeadline
        
        setHeadlineTextLabelConstrains()
    }
    
    private func setTextView() {
        view.addSubview(descriptionTextView)
        descriptionTextView.text = sale.textDescription
        
        setTextViewConstrains()
    }
    
    private func setDivider() {
        view.addSubview(dividerView)
        
        //dividerView.setup()
    }
    
    //MARK: - Basket Button translation
    
    private func setCustomButton() {
        view.addSubview(customButton)
        customButton.pin(to: view)
        
        if isValid {
            customButton.setTitle("Add to basket", for: .normal)
            
            addToBasketAction()
        } else {
            customButton.setTitle("Clear", for: .normal)
            
            clearButtonAction()
        }
    }
    
    // Add to Basket
    private func addToBasketAction() {
        customButton.addTarget(self, action: #selector(addToBasketTapped), for: .touchUpInside)
    }
    
    @objc private func addToBasketTapped() {
        customButton.pressWithEnable()
        customButton.setTitle("Special added!", for: .normal)
        
        if let menuItems = sale.menuItems {
            for menuItem in menuItems {
                coordinator?.passOrderToBasket(menuItem: menuItem)
            }
        }
    }
    
    
    // Go back to Home
    private func clearButtonAction() {
        customButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    @objc private func clearButtonTapped() {
        customButton.press()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    //MARK: - Constraints
    
    private func setScrollViewConstrains() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
    }
    
    private func setHeadlineTextLabelConstrains() {
        headlineTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headlineTextLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            headlineTextLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            headlineTextLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
        
    }
    
    private func setTextViewConstrains() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -70)
        ])
        
    }
    
    private func setDividerViewConstraints() {
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: headlineTextLabel.bottomAnchor, constant: 16),
            dividerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 0.25)
        ])
    }
    
}
