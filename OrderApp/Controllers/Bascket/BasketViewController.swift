//
//  BascketViewController.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit

class BasketViewController: UIViewController {

    var coordinator: MainCoordinator?
    
    var basket: Basket = Basket(numberOfItems: 0, totalSum: 0, menuItems: [])
    
    private var tableView = UITableView()
    
    private var itemCounts: [String: Int] = [:]
    
    private var uniqueMenuItems = [MenuItem]()
    
    private var numberLabel = UILabel()
    
    private var numOfItems = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureTableView()
    }

    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        
    }
    
    func configureNavigationBar() {
        title = "Bascket"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        
        numberLabel.text = "\(basket.menuItems.count)"
        numberLabel.font = UIFont.systemFont(ofSize: 27)
        numberLabel.textColor = .black
        
        let numberItem = UIBarButtonItem(customView: numberLabel)
        navigationItem.rightBarButtonItem = numberItem

    }
    
    
    
    func updateBasket(with newItem: MenuItem) {
        var updatedMenuItems = basket.menuItems
        updatedMenuItems.append(newItem)
        
        basket = Basket(numberOfItems: basket.numberOfItems, totalSum: basket.totalSum, menuItems: updatedMenuItems)
        print(basket.menuItems.count)
        
        sortItemCounts(with: updatedMenuItems)
        filterUniqueMenuItems(with: updatedMenuItems)
        
        tableView.reloadData()
    }

    
    func removeItemFromBasket(at index: Int) {
        var updatedMenuItems = basket.menuItems
        updatedMenuItems.remove(at: index)

        basket = Basket(numberOfItems: basket.numberOfItems, totalSum: basket.totalSum, menuItems: updatedMenuItems)
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

//MARK: - Sorting bascket

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
    
}

//MARK: - Delegate from Cell

extension BasketViewController: BasketCellDelegate {
    
    func didTapAddButton(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell as! BasketCell) else { return }
        
        let menuItem = basket.menuItems[indexPath.row]
        updateBasket(with: menuItem)
        configureNavigationBar()
    }
    
    func didTapSubtractButton(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell as! BasketCell) else { return }
        
        removeItemFromBasket(at: indexPath.row)
        configureNavigationBar()
    }
    
}


