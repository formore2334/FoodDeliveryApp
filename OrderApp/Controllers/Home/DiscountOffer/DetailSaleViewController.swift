//
//  DetailSaleViewController.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import UIKit

class DetailSaleViewController: UIViewController {
    
    var sale: Sale
    
    var salesManager: SalesManager
    
    var coordinator: MainCoordinator?
    
    private let networkManager = NetworkManager()
    
    private let customButton = CustomButton()
    
    //MARK: - Set Variables
    
    private var isAvailable: Bool = true
    
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
    
    //MARK: - Computed property
    
    private var isValid: Bool {
        return sale.menuItemsID != nil
    }

    //MARK: - Init
    
    init(sale: Sale, salesManager: SalesManager, coordinator: MainCoordinator? = nil) {
        self.sale = sale
        self.salesManager = salesManager
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator?.availabilityValidator.delegate = self
        
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listens to notification from last page (when user returnes from final pay page)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(popToRootVC),
                                               name: NSNotification.Name("BackToHomeNotification"),
                                               object: nil)
        
        // Sets color of navigation items to white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        // Checks availability of current sale
        updateButtonAvailability()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.popViewController(animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configurations
    
    private func configureVC() {
        view.backgroundColor = .white
        
        setTitleLabel()
        setScrollView()
        setCustomButton()
        setBackgroundImage()
    }
    
    // Sets sale background image
    private func setBackgroundImage() {
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        getImage()
        setBackgroundImageConstraint()
    }
    
    // Receives image with url
    private func getImage() {
        guard let url = URL(string: sale.backgroundImageURL) else { return }
        
        // Calls a completion handler to get image
        networkManager.fetchImage(url: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.backgroundImageView.image = image
            }
        }
    }
    
    // Returnes to home vc
    @objc func popToRootVC() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    // MARK: - Configure varibles
    
    private func setTitleLabel() {
        view.addSubview(saleTitleLabel)
        saleTitleLabel.text = sale.title
        
        navigationItem.title = saleTitleLabel.text
    }
    
    // Adds all containers to scrollView
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.bounds.width,
                                        height:
                                            headlineTextLabel.bounds.height + descriptionTextView.bounds.height)
        
        scrollView.addSubview(headlineTextLabel)
        scrollView.addSubview(dividerView)
        scrollView.addSubview(descriptionTextView)
       
        setHeadlineTextLabel()
        setDividerView()
        setTextView()
        
        setScrollViewConstrains()
    }
    
    private func setHeadlineTextLabel() {
        view.addSubview(headlineTextLabel)
        headlineTextLabel.text = sale.textHeadline
        
        setHeadlineTextLabelConstrains()
    }
    
    private func setDividerView() {
        view.addSubview(dividerView)
        
        setDividerViewConstraints()
    }
    
    // Config textView with browser opening possibility
    private func setTextView() {
        view.addSubview(descriptionTextView)
        
        // Finds hyperlink inside text description
        let textDescription: String = ""
        let hyperlinkString = textDescription.extractHyperlinkText(in: sale.textDescription)
        
        // Makes text clickable
        descriptionTextView.addHyperLinksToText(originalText: sale.textDescription,
                                                hyperLinks: [hyperlinkString: hyperlinkString])
        
        descriptionTextView.delegate = self
        
        setTextViewConstrains()
    }
    
    // Checks availability of sale
    private func updateButtonAvailability() {
        isAvailable = salesManager.checkAvailablilaty(with: sale, coordinator: coordinator)
        
        isAvailable ? addToBasketAction() : addUnavailableAction()
    }
    
}

//MARK: - Basket Button translations

private extension DetailSaleViewController {
    
    // Sets button depending on current condition
    func setCustomButton() {
        view.addSubview(customButton)
        setCustomButtonConstraints()
        
        if isValid {
            
            // This title for sale with menuItem's
            customButton.setTitle("Add to basket", for: .normal)
        } else {
            
            // This title for sale which contains only info
            customButton.setTitle("Clear", for: .normal)
            clearButtonAction()
        }
        
    }
    
    // Adds to Basket button action
    func addToBasketAction() {
        customButton.addTarget(self, action: #selector(addToBasketTapped), for: .touchUpInside)
    }
    
    @objc func addToBasketTapped() {
        customButton.pressWithEnable()
        customButton.setTitle("Special added!", for: .normal)
        
        // Temp array to passing throw coordinator
        var specialMenuItems: [SpecialMenuItem] = []
        
        // Takes id's from current sale
        if let ids = sale.menuItemsID {
            
            // Receives menuItem's with id's and fills specialMenuItems array
            specialMenuItems = ids.compactMap { id in
                return salesManager.getMenuItem(at: id) as? SpecialMenuItem
            }
            
        }
        
        // Pass received array to coordinator
        coordinator?.passSpecialOrderToBasket(with: specialMenuItems, saleID: sale.id, discountTitle: sale.title)
    }
    
    // Sets unavailable text to custom button
    func addUnavailableAction() {
        customButton.addTarget(self, action: #selector(unavailableTapped), for: .touchUpInside)
    }
    
    @objc func unavailableTapped() {
        customButton.shake()
        customButton.setTitle("Your are already have Speial in basket!", for: .normal)
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

//MARK: - Open Link from textView in browser if needs

extension DetailSaleViewController: UITextViewDelegate {
    
    // Opens hyperlink in browser
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if interaction == .invokeDefaultAction {
            UIApplication.shared.open(URL)
        }
        
        return false
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

//MARK: - Delegate

extension DetailSaleViewController: AvailabilityValidatorDelegate {
    
    // Checks availability of sale
    func unavailableItemsDidChange() {
        updateButtonAvailability()
    }
    
}
