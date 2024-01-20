//
//  BascketViewController.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit

class BasketViewController: UIViewController {

    var coordinator: MainCoordinator?
    
    private let basketManager: BasketManager
    
    private let specialTableView = SpecialTableView()
    
    private let regularTableView = RegularTableView()
    
    //MARK: - Set variables
    
    private var customButton = CustomButton()
    
    private var itemCounterLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private var scrollView = UIScrollView()
    
    private var container = UIView()
    
    private var colorCornerContainer = UIView()
    
    private var spacerBetweenTables = UIView()
    
    private lazy var arrowUpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "specialArrowUp")
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 35)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var arrowDownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "regularArrowDown")
        imageView.frame = CGRect(x: view.bounds.width - 180, y: 0, width: 170, height: 50)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // Setup holders to movable constraints
    private var spacerConstraints: [NSLayoutConstraint] = []
    
    private var colorCornerConteinerConstraints: [NSLayoutConstraint] = []
    
    //MARK: - Init
    
    init(basketManager: BasketManager = BasketManager(basket: Basket(basketItems: [], basketSpecialItems: []))) {
        self.basketManager = basketManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Listens to notification from last page (when user returns from final pay page)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearBasket),
                                               name: Notification.Name("BackToHomeNotification"),
                                               object: nil)
        
        basketManager.delegate = self

        setCustomButton()
        configureTitleLabel()
        configureItemCounterLabel()
        configureVC()
        setAllConstraint()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
   //MARK: - Configurations
    
    // Sets large title on VC
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        attributedStringTitle()
    }
    
    // Sets large total item counter on VC
    private func configureItemCounterLabel() {
        view.addSubview(itemCounterLabel)
        itemCounterLabel.text = "\(basketManager.basketTotalCount)"
        itemCounterLabel.font = UIFont.systemFont(ofSize: 37)
        itemCounterLabel.textColor = .black
    }
    
    // Config VC
    private func configureVC() {
        view.addSubview(scrollView)

        scrollView.addSubview(container)

        container.addSubview(colorCornerContainer)
        colorCornerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(specialTableView)
        
        container.addSubview(spacerBetweenTables)
        spacerBetweenTables.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(regularTableView)
        
        // Sets special table container appearance
        colorCornerContainer.layer.cornerRadius = 10
        colorCornerContainer.backgroundColor = UIColor(red: 255, green: 200, blue: 0, alpha: 0.3)
        
        spacerBetweenTables.addSubview(arrowUpImageView)
        spacerBetweenTables.addSubview(arrowDownImageView)
        
        specialTableView.basketManager = self.basketManager
        regularTableView.basketManager = self.basketManager
        
        specialTableView.reloadData()
        regularTableView.reloadData()
    }
    
    // Set attributes for titleLabel (text + image)
    private func attributedStringTitle() {
        titleLabel.attributedTitleWithImage(title: "Basket", systemImageName: "basket")
    }
    
    //Listens to notification
    @objc private func clearBasket() {
        basketManager.clearBasket()
        updateData()
    }
    
}


//MARK: - Checkout Button translation

private extension BasketViewController {
    
    // Adds custom button on VC
    private func setCustomButton() {
        view.addSubview(customButton)
        customButton.setTitle("\(basketManager.checkoutWithTotalSum)", for: .normal)
        customButton.pin(to: view)
        
        addActionToCustomButton()
    }
    
    // Adds action to custom button with transition to the next (checkout) vc
    private func addActionToCustomButton() {
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
    }
    
    @objc private func customButtonTapped() {
        
        // Checks the possibility of moving to the next vc
        // Makes it
        // And displays the appropriate animation
        if basketManager.basketItemsCount > 0 {
            customButton.press()
            
            let basket = basketManager.basket
            let checkoutListVC = CheckoutListViewController(basket: basket)
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            
            navigationController?.pushViewController(checkoutListVC, animated: true)
        } else {
            customButton.shake()
        }
    }
    
}

//MARK: - Update & adds logic

extension BasketViewController {
    
    // Adds menuItem in regular section of basket
    func addItemToBasket(menuItem: (any MenuItemProtocol)) {
        basketManager.addItemToBasket(with: menuItem)
        
        updateData()
    }
    
    // Adds specialMenuItems in basket
    func addSpecialItemToBasket(with specialMenuItems: [SpecialMenuItem], discountTitle: String) {
        basketManager.addSpecialItemToBasket(with: specialMenuItems, discountTitle: discountTitle)
        
        updateData()
    }
    
    // Updates data inside tables & sets new value in tabBarLabel
    private func updateData() {
        coordinator?.configureTabBarLabel(with: basketManager.basketTotalCount)
        regularTableView.reloadData()
        specialTableView.reloadData()
    }
    
}

// Update values inside BasketViewController if they have changed
extension BasketViewController: BasketManagerDelegate {
    
    func valuesDidUpdate() {
        self.itemCounterLabel.text = "\(basketManager.basketTotalCount)"
        self.customButton.setTitle("\(basketManager.checkoutWithTotalSum)", for: .normal)
        self.coordinator?.configureTabBarLabel(with: basketManager.basketTotalCount)
    
        setMovableConstraints()
    }
    
}

//MARK: - Constraints

private extension BasketViewController {
    
    func setAllConstraint() {
        setItemCounterLabelConstraints()
        setTitleLabelConstraints()
        setTablesContentConstraints()
        
        setMovableConstraints()
    }
    
    // Header counter constraints
    func setItemCounterLabelConstraints() {
        itemCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            itemCounterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            itemCounterLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    // Title constraints
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: itemCounterLabel.bottomAnchor, constant: 35),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // ScrollView & Tables content constraints
    func setTablesContentConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        specialTableView.translatesAutoresizingMaskIntoConstraints = false
        regularTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: customButton.topAnchor, constant: -20),
            
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            specialTableView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            specialTableView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            specialTableView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            
            regularTableView.topAnchor.constraint(equalTo: spacerBetweenTables.bottomAnchor),
            regularTableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            regularTableView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            regularTableView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
}

//MARK: - Movable constraints

private extension BasketViewController {
    
    // Adds constraints based on the current values inside the array
    func setMovableConstraints() {
        if basketManager.basket.basketSpecialItems.isEmpty {
            
            // Activate & Deactivate constaints for color container
            NSLayoutConstraint.deactivate(colorCornerConteinerConstraints)
            
            // Sets zero frame to color container
            colorCornerConteinerConstraints = [
                colorCornerContainer.heightAnchor.constraint(equalToConstant: 0),
                colorCornerContainer.widthAnchor.constraint(equalToConstant: 0)
            ]
            
            NSLayoutConstraint.activate(colorCornerConteinerConstraints)
            
            
            // Activate & Deactivate constaints for spacer container with arrows
            NSLayoutConstraint.deactivate(spacerConstraints)
            
            // Sets other start point to spacer container constraints & remove top padding
            spacerConstraints = [
                
                spacerBetweenTables.topAnchor.constraint(equalTo: specialTableView.bottomAnchor, constant: 0),
                spacerBetweenTables.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                spacerBetweenTables.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                spacerBetweenTables.heightAnchor.constraint(equalToConstant: 0),
            ]
            
            NSLayoutConstraint.activate(spacerConstraints)
            
            // Sets zero frame to arrow image view's
            arrowUpImageView.frame = .zero
            arrowDownImageView.frame = .zero
        } else {
            
            // If basket is not empty, returns all values to their default state
            
            // Activate & Deactivate constaints for color container
            NSLayoutConstraint.deactivate(colorCornerConteinerConstraints)
            
            colorCornerConteinerConstraints = [
                
                colorCornerContainer.topAnchor.constraint(equalTo: specialTableView.topAnchor, constant: -10),
                colorCornerContainer.leadingAnchor.constraint(equalTo: specialTableView.leadingAnchor, constant: 40),
                colorCornerContainer.trailingAnchor.constraint(equalTo: specialTableView.trailingAnchor),
                colorCornerContainer.bottomAnchor.constraint(equalTo: specialTableView.bottomAnchor, constant: 10),
            ]
            
            NSLayoutConstraint.activate(colorCornerConteinerConstraints)
            
            
            // Activate & Deactivate constaints for spacer container with arrows
            NSLayoutConstraint.deactivate(spacerConstraints)
            
            // Sets normally spacer container constraints & adds top padding
            spacerConstraints = [
                
                spacerBetweenTables.topAnchor.constraint(equalTo: specialTableView.bottomAnchor, constant: 20),
                spacerBetweenTables.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                spacerBetweenTables.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                spacerBetweenTables.heightAnchor.constraint(equalToConstant: 50),
            ]
            
            NSLayoutConstraint.activate(spacerConstraints)
            
            // Return frame's to arrow image view's
            arrowUpImageView.frame = CGRect(x: 0, y: 0, width: 120, height: 35)
            arrowDownImageView.frame = CGRect(x: view.bounds.width - 180, y: 0, width: 170, height: 50)
        }
        
        // Hides arroDownImageView if basketItems in basket is empty
        if basketManager.basket.basketItems.isEmpty {
            arrowDownImageView.isHidden = true
        } else {
            arrowDownImageView.isHidden = false
        }
        
    }
    
}
