//
//  SalesManager.swift
//  OrderApp
//
//  Created by ForMore on 30/11/2023.
//

import Foundation


struct SalesManager {
    
    var sales: [Sale]
    
    init(sales: [Sale] = Sale.mockData) {
        self.sales = sales
    }
    
    
    func getCurrentSale(with menuItem: MenuItem) -> Sale? {
        return sales.first { $0.menuItems?.contains(menuItem) ?? false }
    }

    func configureAttributedText(with sale: Sale) -> NSMutableAttributedString {
        
       let link = checkLink(in: sale.textDescription)
        
        let attributedString = NSMutableAttributedString(string: sale.textDescription)
            let linkRange = (sale.textDescription as NSString).range(of: String(describing: link))
            attributedString.addAttribute(.link, value: String(describing: link), range: linkRange)
        
        return attributedString
    }
    
    func checkLink(in text: String) -> URL? {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        for match in matches {
            guard let url = match.url else { continue }
            return url
        }
        
        return nil
    }

    
}
