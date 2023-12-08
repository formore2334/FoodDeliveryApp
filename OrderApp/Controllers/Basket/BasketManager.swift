//
//  BasketManager.swift
//  OrderApp
//
//  Created by ForMore on 07/12/2023.
//

import Foundation


class BasketManager {
    
    var basket: Basket
    
    init(basket: Basket) {
        self.basket = basket
    }
    
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
    
    
    
    func clearBasket() {
        self.basket.basketItems.removeAll()
    }
    
    func addItemToBasket(with menuItem: MenuItem) {
        if let existingBasketItemIndex = basket.basketItems.firstIndex(where: { $0.menuItem == menuItem }) {
            var basketItem = basket.basketItems[existingBasketItemIndex]
            basketItem.count += 1
            basket.basketItems[existingBasketItemIndex] = basketItem
        } else {
            let newBasketItem = BasketItem(menuItem: menuItem, count: 1)
            basket.basketItems.append(newBasketItem)
        }
    }

    func removeItemFromBasket(with menuItem: MenuItem) {
        if let existingBasketItemIndex = basket.basketItems.firstIndex(where: { $0.menuItem == menuItem }) {
            var basketItem = basket.basketItems[existingBasketItemIndex]
            basketItem.count -= 1
            if basketItem.count == 0 {
                basket.basketItems.remove(at: existingBasketItemIndex)
            } else {
                basket.basketItems[existingBasketItemIndex] = basketItem
            }
        }
    }

    func incrementItemCount(at index: Int) {
        var basketItem = basket.basketItems[index]
        basketItem.count += 1
        basket.basketItems[index] = basketItem
    }

    func decrementItemCount(at index: Int) {
        var basketItem = basket.basketItems[index]
        basketItem.count -= 1
        if basketItem.count == 0 {
            basket.basketItems.remove(at: index)
        } else {
            basket.basketItems[index] = basketItem
        }
    }
    
}
