//
//  SpecialTableView.swift
//  OrderApp
//
//  Created by ForMore on 28/12/2023.
//

import UIKit

class SpecialTableView: UITableView {
    
    var basketManager: BasketManager?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        self.dataSource = self
        self.register(SpecialTableViewCell.self,
                      forCellReuseIdentifier: SpecialTableViewCell.identifier)
        self.isScrollEnabled = false
        self.allowsSelection = false
        self.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Updates table layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
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

extension SpecialTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let basketManager = basketManager else { return 0 }
        
        return basketManager.basket.basketSpecialItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let basketManager = basketManager else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SpecialTableViewCell.identifier,
                                                 for: indexPath) as! SpecialTableViewCell
        
        let basketSpecialItem = basketManager.basket.basketSpecialItems[indexPath.row]
        let currentRow = indexPath.row + 1
        
        cell.configure(basketSpecialItem: basketSpecialItem, cellNumber: currentRow)
        cell.delegate = self
        
        return cell
    }
    
}

// MARK: - Delegate

extension SpecialTableView: SpecialCellDelegate {
    
    func deleteButtonDidTapped(_ cell: UITableViewCell) {
        guard let indexPath = self.indexPath(for: cell as! SpecialTableViewCell) else { return }
        
        let index = indexPath.row
        basketManager?.deleteSpecialFromBasket(at: index)
        self.reloadData()
    }
    
}
