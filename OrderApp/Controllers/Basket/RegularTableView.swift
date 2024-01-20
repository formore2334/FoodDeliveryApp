//
//  RegularTableView.swift
//  OrderApp
//
//  Created by ForMore on 28/12/2023.
//

import UIKit

class RegularTableView: UITableView {
    
    var basketManager: BasketManager?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.register(RegularCell.self, forCellReuseIdentifier: RegularCell.identifier)
        self.rowHeight = 80
        self.isScrollEnabled = false
        self.allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Updates internal size of table
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    // Returns the size of the table contents
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }

}

// MARK: - Data Source

extension RegularTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let basketManager = basketManager else { return 0 }
        return basketManager.basket.basketItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let basketManager = basketManager else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RegularCell.identifier, for: indexPath) as! RegularCell
        
        let basketItem = basketManager.basket.basketItems[indexPath.row]
        let totalPrice = basketManager.basketItemTotalPrice(basketItem)
        let itemsCount = basketItem.count
        
        let menuItems = basketManager.basket.basketItems.map { $0.menuItem }
        let menuItem = menuItems[indexPath.row]
        
        cell.configure(menuItem: menuItem, itemsCount: itemsCount, totalPrice: totalPrice)
        cell.delegate = self
        
        return cell
    }
    
}

//MARK: - Updates & adds logic

extension RegularTableView {
    
    // Adds menuItem in regular section of basket
    func addItemToBasket(menuItem: (any MenuItemProtocol)) {
        guard let basketManager = basketManager else { return }
        
        basketManager.addItemToBasket(with: menuItem)
        
        updateData()
    }

    // Removes menuItem from regular section of basket
    func removeItemFromBasket(menuItem: (any MenuItemProtocol)) {
        guard let basketManager = basketManager else { return }
        
        basketManager.removeItemFromBasket(with: menuItem)
        
        updateData()
    }

    // Increments regular item count
    private func incrementItemCount(at index: Int) {
        guard let basketManager = basketManager else { return }
        
        basketManager.incrementItemCount(at: index)
        
        updateData()
    }

    // Decrements regular item count
    private func decrementItemCount(at index: Int) {
        guard let basketManager = basketManager else { return }
        
        basketManager.decrementItemCount(at: index)
        
        updateData()
    }
    
    // Reloads data in table
    private func updateData() {
        self.reloadData()
    }
    
}

//MARK: - Delegate

extension RegularTableView: RegularCellDelegate {
    
    func didTapAddButton(_ cell: UITableViewCell) {
        guard let indexPath = self.indexPath(for: cell as! RegularCell) else { return }
        
        let index = indexPath.row
        incrementItemCount(at: index)
    }
    
    func didTapSubtractButton(_ cell: UITableViewCell) {
        guard let indexPath = self.indexPath(for: cell as! RegularCell) else { return }
        
        let index = indexPath.row
        decrementItemCount(at: index)
    }
}
