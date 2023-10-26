//
//  BascketViewController.swift
//  OrderApp
//
//  Created by ForMore on 24/10/2023.
//

import UIKit

class BascketViewController: UIViewController {

    private var bascket = Bascket.mockData
    
    private var tableView = UITableView()
    
    private var itemCounts: [String: Int] = [:]
    
    private var uniqueMenuItems = [MenuItem]()
    
    private var numberLabel = UILabel()
    
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
        tableView.register(BascketCell.self, forCellReuseIdentifier: BascketCell.identifier)
        
        sortItemCounts()
        filterUniqueMenuItems()
    }
    
    func configureNavigationBar() {
        title = "Bascket"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        numberLabel.text = "\(bascket.numberOfItems)"
        numberLabel.font = UIFont.systemFont(ofSize: 27)
        numberLabel.textColor = .black
        
        let numberItem = UIBarButtonItem(customView: numberLabel)
        navigationItem.rightBarButtonItem = numberItem

    }
    
//    func setNumberLabelConstraints() {
//        numberLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            numberLabel.centerYAnchor.constraint(equalTo: titleView?.centerYAnchor)
//        ])
//    }
 
}


extension BascketViewController: UITableViewDelegate {
    
}

extension BascketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BascketCell.identifier, for: indexPath) as! BascketCell
        
        if uniqueMenuItems.count > 0 {
            let menuItem = uniqueMenuItems[indexPath.row]
            let itemCounts = itemCounts[menuItem.title] ?? 0
            cell.configureCell(menuItem: menuItem, itemCounts: itemCounts)
        } else {
            return UITableViewCell()
        }
        
        return cell
    }
 
}

//MARK: - Sorting bascket

extension BascketViewController {
    
    func sortItemCounts() {

        for menuItem in bascket.menuItems {
            if let count = itemCounts[menuItem.title] {
                itemCounts[menuItem.title] = count + 1
            } else {
                itemCounts[menuItem.title] = 1
            }
        }

    }
    
    
    func filterUniqueMenuItems() {
        var uniqueTitles: Set<String> = []
        
        for menuItem in bascket.menuItems {
            if !uniqueTitles.contains(menuItem.title) {
                uniqueTitles.insert(menuItem.title)
                uniqueMenuItems.append(menuItem)
            }
        }
        
    }
    
}
