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
    
    private var itemCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        tableView.register(BascketCell.self, forCellReuseIdentifier: BascketCell.identifier)
    }
    
}


extension BascketViewController: UITableViewDelegate {
    
}

extension BascketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bascket.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BascketCell.identifier, for: indexPath) as! BascketCell
        
        cell.configureCell(menuItem: bascket.menuItems[indexPath.row])
        return cell
    }
 
}
