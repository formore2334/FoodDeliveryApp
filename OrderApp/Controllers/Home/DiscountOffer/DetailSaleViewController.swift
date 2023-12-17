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
    
    private let customButton = CustomButton()
    
    private var saleTitleLabel = UILabel()
    
    private lazy var dividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor.gray
        return dividerView
    }()
    
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
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var isValid: Bool {
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
    
    // Return navigation title color to black after view is disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.tintColor = .black
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configure DetailInfo VC
    
    private func configureVC() {
        view.backgroundColor = .white
        
        setTitleLabel()
        setScrollView()
        setCustomButton()
        setBackgroundImage()
    }
    
    private func setBackgroundImage() {
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        getImage()
        setBackgroundImageConstraint()
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
        scrollView.contentSize = CGSize(width: view.bounds.width,
                                        height:
                                            headlineTextLabel.bounds.height + descriptionTextView.bounds.height)
        
        scrollView.addSubview(headlineTextLabel)
        scrollView.addSubview(descriptionTextView)
       
        setHeadlineTextLabel()
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
        let hyperlinkString = extractHyperlinkText(in: sale.textDescription)
        descriptionTextView.addHyperLinksToText(originalText: sale.textDescription, hyperLinks: [hyperlinkString: hyperlinkString])
        
        descriptionTextView.delegate = self
        
        setTextViewConstrains()
    }
    
}

//MARK: - Open Link from textView in browser if needs

extension DetailSaleViewController: UITextViewDelegate {
    
    private func extractHyperlinkText(in text: String) -> String {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        for match in matches {
            guard let url = match.url else { continue }
            return String(describing: url)
        }
        
        return ""
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if interaction == .invokeDefaultAction {
            UIApplication.shared.open(URL)
        }
        return false
    }
    
}


//MARK: - Basket Button translations

private extension DetailSaleViewController {
    
    func setCustomButton() {
        view.addSubview(customButton)
        setCustomButtonConstraints()
        
        if isValid {
            customButton.setTitle("Add to basket", for: .normal)
            
            addToBasketAction()
        } else {
            customButton.setTitle("Clear", for: .normal)
            
            clearButtonAction()
        }
    }
    
    // Add to Basket
    func addToBasketAction() {
        customButton.addTarget(self, action: #selector(addToBasketTapped), for: .touchUpInside)
    }
    
    @objc func addToBasketTapped() {
        customButton.pressWithEnable()
        customButton.setTitle("Special added!", for: .normal)
        
        if let menuItems = sale.menuItems {
            for menuItem in menuItems {
                coordinator?.passOrderToBasket(menuItem: menuItem)
            }
        }
    }
    
    // Go back to Home
    func clearButtonAction() {
        customButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    @objc func clearButtonTapped() {
        customButton.press()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

//MARK: - Constraints

private extension DetailSaleViewController {

    func setScrollViewConstrains() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
    }
    
    func setHeadlineTextLabelConstrains() {
        headlineTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headlineTextLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            headlineTextLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            headlineTextLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
        
    }
    
    func setTextViewConstrains() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -70)
        ])
        
    }
    
    func setDividerViewConstraints() {
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: headlineTextLabel.bottomAnchor, constant: 16),
            dividerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 0.25)
        ])
    }
    
    func setBackgroundImageConstraint() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setCustomButtonConstraints() {
        customButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customButton.heightAnchor.constraint(equalToConstant: 40.0),
            customButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            customButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            customButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
}
