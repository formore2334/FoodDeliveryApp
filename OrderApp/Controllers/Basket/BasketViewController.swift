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
    
    private var tableView = UITableView()
    
    private var itemCounterLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private var customButton = CustomButton()
    
    init(basketManager: BasketManager = BasketManager(basket: Basket(basketItems: []))) {
        self.basketManager = basketManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearBasket),
                                               name: Notification.Name("BackToHomeNotification"),
                                               object: nil)

        setCustomButton()
        configureTitleLabel()
        configureItemCounterLabel()
        configureTableView()
        setAllConstraint()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
   //MARK: - Configurations
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        attributedStringTitle()
    }
    
    private func configureItemCounterLabel() {
        view.addSubview(itemCounterLabel)
        itemCounterLabel.text = "\(basketManager.basketTotalCount)"
        itemCounterLabel.font = UIFont.systemFont(ofSize: 37)
        itemCounterLabel.textColor = .black
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
    }
    
    // Set attributes for titleLabel (text + image)
    private func attributedStringTitle() {
        let attributedText = NSMutableAttributedString(string: "Basket" + " ")
        
        let basketImageAttachment = NSTextAttachment()
        basketImageAttachment.image = UIImage(systemName: "basket")
        
        let imageSize = CGSize(width: 35, height: 35)
        basketImageAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: -3.5), size: imageSize)
        
        // Create NSAttributedString with basket image
        let basketImageString = NSAttributedString(attachment: basketImageAttachment)
        
        attributedText.append(basketImageString)
        
        // Set attributes for line
        attributedText.addAttributes([
            .font: UIFont.boldSystemFont(ofSize: 30),
            .foregroundColor: UIColor.black
        ], range: NSRange(location: 0, length: attributedText.length))
    
     titleLabel.attributedText = attributedText
    }
    
    //Listening to notification
    @objc private func clearBasket() {
        basketManager.clearBasket()
        updateData()
    }
    
    //MARK: - Checkout Button translation
    
    private func setCustomButton() {
        view.addSubview(customButton)
        customButton.setTitle("\(basketManager.checkoutWithTotalSum)", for: .normal)
        customButton.pin(to: view)
        
        addActionToCustomButton()
    }
    
    private func addActionToCustomButton() {
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
    }
    
    @objc private func customButtonTapped() {
        if basketManager.basketItemsCount > 0 {
            customButton.press()
            
            let checkoutListVC = CheckoutListViewController(basket: basketManager.basket)
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

            navigationController?.pushViewController(checkoutListVC, animated: true)
        } else {
            customButton.shake()
        }
    }
    
    
    //MARK: - Constraints
    
    private func setAllConstraint() {
        setItemCounterLabelConstraints()
        setTitleLabelConstraints()
        setTableViewConstraints()
    }
    
    // Header Info constraints
    private func setItemCounterLabelConstraints() {
        itemCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            itemCounterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            itemCounterLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: itemCounterLabel.bottomAnchor, constant: 35),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // TableView constraints
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: customButton.topAnchor, constant: -20)
        ])
    }
    
}

//MARK: - Data Source

extension BasketViewController: UITableViewDelegate {
    
}

extension BasketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketManager.basketItemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as! BasketCell
        let basketItem = basketManager.basket.basketItems[indexPath.row]
        let totalPrice = basketManager.basketItemTotalPrice(basketItem)
        
        cell.configure(menuItem: basketItem.menuItem, itemCounts: basketItem.count, totalPrice: totalPrice)
        cell.delegate = self
        
        return cell
    }

}

//MARK: - Update & Sorting logic

extension BasketViewController {
    
    public func addItemToBasket(menuItem: (any MenuItemProtocol)) {
        basketManager.addItemToBasket(with: menuItem)
        
        updateData()
    }

    public func removeItemFromBasket(menuItem: (any MenuItemProtocol)) {
        basketManager.removeItemFromBasket(with: menuItem)
        
        updateData()
    }

    private func incrementItemCount(at index: Int) {
        basketManager.incrementItemCount(at: index)
        
        updateData()
    }

    private func decrementItemCount(at index: Int) {
        basketManager.decrementItemCount(at: index)
     
        updateData()
    }
    
    private func updateData() {
        setCustomButton()
        configureItemCounterLabel()
        coordinator?.configureTabBarLabel(with: basketManager.basketTotalCount)
        tableView.reloadData()
    }
    
}

//MARK: - Delegate

extension BasketViewController: BasketCellDelegate {
    
    func didTapAddButton(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell as! BasketCell) else { return }
        
        let index = indexPath.row
        incrementItemCount(at: index)
    }
    
    func didTapSubtractButton(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell as! BasketCell) else { return }
        
        let index = indexPath.row
        decrementItemCount(at: index)
    }
    
}


