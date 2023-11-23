//
//  BascketViewController.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit

class BasketViewController: UIViewController {

    var coordinator: MainCoordinator?
    
    var basket: Basket = Basket(basketItems: [])
    
    private var tableView = UITableView()
    
    private var itemCounterLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private var customButton = CustomButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitleLabel()
        configureItemCounterLabel()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setCustomButton()
        addActionToCustomButton()
    }
    
    
   //MARK: - Configurations
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        attributedStringTitle()
        
        setTitleLabelConstraints()
    }
    
    private func configureItemCounterLabel() {
        view.addSubview(itemCounterLabel)
        itemCounterLabel.text = "\(basket.totalCount)"
        itemCounterLabel.font = UIFont.systemFont(ofSize: 37)
        itemCounterLabel.textColor = .black
        
        setItemCounterLabelConstraints()
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        
        setTableViewConstraints()
    }
    
    // Set attributes for titleLabel (text + image)
    private func attributedStringTitle() {
        let attributedText = NSMutableAttributedString(string: "Basket ")
        
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
    
    //MARK: - Checkout Button translation
    
    private func setCustomButton() {
        view.addSubview(customButton)
        customButton.setTitle("Checkout", for: .normal)
        customButton.pin(to: view)
    }
    
    private func addActionToCustomButton() {
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
    }
    
    @objc private func customButtonTapped() {
        if basket.basketItems.count > 0 {
            customButton.press()
            
            let checkoutListVC = CheckoutListViewController(basket: basket)
            navigationController?.pushViewController(checkoutListVC, animated: true)
        } else {
            customButton.shake()
        }
    }
    
    
    //MARK: - Constraints
    
    // Header constraints
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setItemCounterLabelConstraints() {
        itemCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            itemCounterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            itemCounterLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    
    // TableView constraints
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

//MARK: - Data Source

extension BasketViewController: UITableViewDelegate {
    
}

extension BasketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.basketItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as! BasketCell
        let basketItem = basket.basketItems[indexPath.row]
        
        cell.configure(menuItem: basketItem.menuItem, itemCounts: basketItem.count)
        cell.delegate = self
        
        return cell
    }

}

//MARK: - Update & Sorting logic

extension BasketViewController {
    
    public func addItemToBasket(menuItem: MenuItem) {
        if let existingBasketItemIndex = basket.basketItems.firstIndex(where: { $0.menuItem == menuItem }) {
            var basketItem = basket.basketItems[existingBasketItemIndex]
            basketItem.count += 1
            basket.basketItems[existingBasketItemIndex] = basketItem
        } else {
            let newBasketItem = BasketItem(menuItem: menuItem, count: 1)
            basket.basketItems.append(newBasketItem)
        }
        
        updateData()
    }

    public func removeItemFromBasket(menuItem: MenuItem) {
        if let existingBasketItemIndex = basket.basketItems.firstIndex(where: { $0.menuItem == menuItem }) {
            var basketItem = basket.basketItems[existingBasketItemIndex]
            basketItem.count -= 1
            if basketItem.count == 0 {
                basket.basketItems.remove(at: existingBasketItemIndex)
            } else {
                basket.basketItems[existingBasketItemIndex] = basketItem
            }
        }
        
        updateData()
    }

    private func incrementItemCount(at index: Int) {
        var basketItem = basket.basketItems[index]
        basketItem.count += 1
        basket.basketItems[index] = basketItem
        
        updateData()
    }

    private func decrementItemCount(at index: Int) {
        var basketItem = basket.basketItems[index]
        basketItem.count -= 1
        if basketItem.count == 0 {
            basket.basketItems.remove(at: index)
        } else {
            basket.basketItems[index] = basketItem
        }
     
        updateData()
    }
    
    private func updateData() {
        setCustomButton()
        configureItemCounterLabel()
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


