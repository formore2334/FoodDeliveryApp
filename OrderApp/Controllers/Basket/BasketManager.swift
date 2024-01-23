//
//  BasketManager.swift
//  OrderApp
//
//  Created by ForMore on 07/12/2023.
//

import Foundation


protocol BasketManagerDelegate: AnyObject {
    func valuesDidUpdate()
}

class BasketManager {
    
    var basket: Basket {
        didSet {
            delegate?.valuesDidUpdate()
            sendNotification()
        }
    }
    
    weak var delegate: BasketManagerDelegate?
    
    init(basket: Basket) {
        self.basket = basket
    }
    
    //MARK: - Computed property's
    
    var basketItemsCount: Int {
        return basket.basketItems.count
    }
    
    var checkoutWithTotalSum: String {
        if basket.totalSum > 0.0 {
            return "Checkout" + " " + " " + "\(basket.totalSum)$"
        } else {
            return "Add something in basket"
        }
        
    }
    
    var basketTotalCount: Int {
        return basket.totalCount
    }
    
    
    
    // MARK: - Methods
    
    // Sends basketSpecialItems to AvailabilityValidator
    private func sendNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("BasketSpecialItemsDidCangeNotification"),
                                        object: basket.basketSpecialItems)
    }
    
    // Deletes all content from basket
    func clearBasket() {
        self.basket.basketItems.removeAll()
        self.basket.basketSpecialItems.removeAll()
    }
    
    // Returns new valid price & old invalid price to priceLabel for cell's
    func basketItemTotalPrice(_ basketItem: BasketItem) -> (Double, Double) {
        
        // Checks for conforms with the protocol Discountable
        if let menuItem = basketItem.menuItem as? (any Discountable) {
            
            // Multiply total price by the number of items (count) in BasketItem. Leaves two decimal places
            let newTotalPrice = (menuItem.newPrice * Double(basketItem.count)).twoDigitsFormat()
            let oldTotalPrice = (menuItem.price * Double(basketItem.count)).twoDigitsFormat()
            
            return (newTotalPrice, oldTotalPrice)
        } else {
            
            // Always returns the input value because the counter is always one. Leaves two decimal places
            let newTotalPrice = (basketItem.menuItem.price * Double(basketItem.count)).twoDigitsFormat()
            
            return (newTotalPrice, 0)
        }
        
    }
    
    //MARK: - Regular & Discount table items adding & deleting logic
    
    // Adds menuItem in basket
    func addItemToBasket(with menuItem: (any MenuItemProtocol)) {
        
        // Finds an existing index in the basket array
        if let existingBasketItemIndex = basket.basketItems.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            
            // Finds an existing regular basketItem
            var basketItem = basket.basketItems[existingBasketItemIndex]
            
            // Adds one to the counter inside BasketItem
            basketItem.count += 1
            
            // Assigns a new value at index
            basket.basketItems[existingBasketItemIndex] = basketItem
        } else {
            
            // Creates a new item and adds it to the end of the array
            let newBasketItem = BasketItem(menuItem: menuItem, count: 1)
            basket.basketItems.append(newBasketItem)
        }
    }
    
    // Remove menuItem from basket
    func removeItemFromBasket(with menuItem: (any MenuItemProtocol)) {
        
        // Finds an existing index in the basket array
        if let existingBasketItemIndex = basket.basketItems.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            
            // Finds an existing regular basketItem
            var basketItem = basket.basketItems[existingBasketItemIndex]
            
            // Remove one from BasketItem
            basketItem.count -= 1
            
            // If the counter is zero, deletes the item, otherwise replaces the value in the array
            if basketItem.count == 0 {
                basket.basketItems.remove(at: existingBasketItemIndex)
            } else {
                basket.basketItems[existingBasketItemIndex] = basketItem
            }
            
        }
        
    }
    
    // Increments item counter in regular basketItems array
    func incrementItemCount(at index: Int) {
        guard index >= 0 else { return }
        
        var basketItem = basket.basketItems[index]
        basketItem.count += 1
        basket.basketItems[index] = basketItem
    }
    
    // Decrements item counter in regular basketItems array
    func decrementItemCount(at index: Int) {
        guard index >= 0 else { return }
        
        var basketItem = basket.basketItems[index]
        basketItem.count -= 1
        if basketItem.count == 0 {
            basket.basketItems.remove(at: index)
        } else {
            basket.basketItems[index] = basketItem
        }
    }
    
    //MARK: - Spacial table items adding & deleting logic
    
    // Adds specialMenuItem's in basket
    func addSpecialItemToBasket(with specialMenuItems: [SpecialMenuItem], saleID: Int, discountTitle: String) {
        
        // Creates temp array of SpecialItem's
        var specialItems: [BasketSpecialItem.SpecialItem] = []
        
        for specialMenuItem in specialMenuItems {
            
            // Finds an existing index in the basket array
            if let existingSpecialItemIndex = specialItems.firstIndex(where: { $0.menuItem.id == specialMenuItem.id }) {
                
                // Finds an existing special basketItem
                var specialItem = specialItems[existingSpecialItemIndex]
                
                // Adds one to the counter inside SpecialBasketItem
                specialItem.count += 1
                
                // Assigns a new value at index
                specialItems[existingSpecialItemIndex] = specialItem
            } else {
                
                // Creates a new special item and adds it to the end of the basketSpecialItems array
                let specialItem = BasketSpecialItem.SpecialItem(menuItem: specialMenuItem, count: 1)
                specialItems.append(specialItem)
            }
            
        }
        
        // Creates a new basket item and adds it to the end of the basket array
        let basketSpecialItem = BasketSpecialItem(saleID: saleID, discountTitle: discountTitle, specialMenuItems: specialItems)
        basket.basketSpecialItems.append(basketSpecialItem)
    }

    // Deletes special item from basketSpecialItems array inside basket
    func deleteSpecialFromBasket(at index: Int) {
        guard index >= 0 && index < basket.basketSpecialItems.count else { return }
        
        basket.basketSpecialItems.remove(at: index)
    }
    
    
}
