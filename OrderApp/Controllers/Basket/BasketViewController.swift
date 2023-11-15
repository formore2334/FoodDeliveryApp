//
//  BascketViewController.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit

class BasketViewController: UIViewController {

    var coordinator: MainCoordinator?
    
    var basket: Basket = Basket(totalSum: 0, menuItems: [])
    
    private var tableView = UITableView()
    
    private var itemCounts: [String: Int] = [:]
    
    private var uniqueMenuItems = [MenuItem]()
    
    private var itemCounterLabel = UILabel()
    
    private var titleLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitleLabel()
        configureItemCounterLabel()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
   //MARK: - Configurations
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        attributedStringTitle()
        
        setTitleLabelConstraints()
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
    
    func configureItemCounterLabel() {
        view.addSubview(itemCounterLabel)
        itemCounterLabel.text = "\(basket.menuItems.count)"
        itemCounterLabel.font = UIFont.systemFont(ofSize: 37)
        itemCounterLabel.textColor = .black
        
        setItemCounterLabelConstraints()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        
        setTableViewConstraints()
    }
    
    
    //MARK: - Constraints
    
    // Header constraints
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setItemCounterLabelConstraints() {
        itemCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            itemCounterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            itemCounterLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    
    // TableView constraints
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension BasketViewController: UITableViewDelegate {
    
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueMenuItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as! BasketCell
        
        if uniqueMenuItems.count > 0 {
            let menuItem = uniqueMenuItems[indexPath.row]
            let itemCounts = self.itemCounts[menuItem.title] ?? 0
            
            cell.delegate = self
            cell.configureCell(menuItem: menuItem, itemCounts: itemCounts)
        } else {
            return UITableViewCell()
        }
        
        return cell
    }
 
}

//MARK: - Update & Sorting logic

extension BasketViewController {

    func sortItemCounts(with menuItems: [MenuItem]) {
        self.itemCounts = [:]
        
        for menuItem in menuItems {
            if let count = self.itemCounts[menuItem.title] {
                self.itemCounts[menuItem.title] = count + 1
            } else {
                self.itemCounts[menuItem.title] = 1
            }
        }
    }

    func filterUniqueMenuItems(with menuItems: [MenuItem]) {
        var uniqueTitles: Set<String> = []
        var filteredMenuItems: [MenuItem] = []
        
        for menuItem in menuItems {
            if !uniqueTitles.contains(menuItem.title) {
                uniqueTitles.insert(menuItem.title)
                filteredMenuItems.append(menuItem)
            }
        }
        
        self.uniqueMenuItems = filteredMenuItems
    }
    
    
    func updateBasket(with newItem: MenuItem) {
        var updatedMenuItems = basket.menuItems
        updatedMenuItems.append(newItem)
        
        sortItemCounts(with: updatedMenuItems)
        filterUniqueMenuItems(with: updatedMenuItems)
        
        basket = Basket(totalSum: basket.totalSum, menuItems: updatedMenuItems)
        print(basket.menuItems.count)
        print("DEBUG basketVC add: ", basket.menuItems)

    }

    
    func removeItemFromBasket(at index: Int) {
        guard index >= 0 && index < basket.menuItems.count else { return }
        
        var updatedMenuItems = basket.menuItems
        updatedMenuItems.remove(at: index)
        
        sortItemCounts(with: updatedMenuItems)
        filterUniqueMenuItems(with: updatedMenuItems)

        basket = Basket(totalSum: basket.totalSum, menuItems: updatedMenuItems)
        print(basket.menuItems.count)
        print("DEBUG basketVC remove: ", basket.menuItems)
        
    }
    
}

//MARK: - Delegate from Cell

extension BasketViewController: BasketCellDelegate {
    
    func didTapAddButton(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell as! BasketCell) else { return }
        
        let menuItem = basket.menuItems[indexPath.row]
        updateBasket(with: menuItem)
        configureItemCounterLabel()
    }
    
    func didTapSubtractButton(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell as! BasketCell) else { return }
        
        removeItemFromBasket(at: indexPath.row)
        configureItemCounterLabel()
    }
    
}


