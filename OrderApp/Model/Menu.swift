//
//  MenuModel.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import Foundation


protocol Discountble {
    var sale: Double { get }
    var newPrice: Double { get }
}

class MenuItem: Hashable {
    
    var id = UUID()
    let price: Double
    let imageURL: String
    let title: String
    let description: String
    
    init(price: Double, imageURL: String, title: String, description: String) {
        self.price = price
        self.imageURL = imageURL
        self.title = title
        self.description = description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        lhs.id == rhs.id
    }
    
}

final class DiscountMenuItem: MenuItem, Discountble {
    let sale: Double
    
    init(sale: Double, price: Double, imageURL: String, title: String, description: String) {
        self.sale = sale
        super.init(price: price, imageURL: imageURL, title: title, description: description)
    }
    
    var newPrice: Double {
        let newPrice = price - (price / 100 * sale)
        return Double(String(format: "%.2f", newPrice)) ?? 0.0
    }
    
}

final class SpecialSaleMenuItem: MenuItem, Discountble {
    let sale: Double
    
    init(sale: Double, price: Double, imageURL: String, title: String, description: String) {
        self.sale = sale
        super.init(price: price, imageURL: imageURL, title: title, description: description)
    }
    
    var newPrice: Double {
        let newPrice = price - (price / 100 * sale)
        return Double(String(format: "%.2f", newPrice)) ?? 0.0
    }
    
}

struct Menu {
    let imageName: String
    let title: String
    let menuItem: [MenuItem]
}

extension Menu {
    static let mockData: [Menu] = [
        Menu(imageName: "comboLogo", title: "Combo", menuItem: [
            MenuItem(price: 16.99, imageURL: "https://img.freepik.com/premium-photo/fresh-tasty-burger-french-fries-soft-drink-dark-background_113876-3426.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Grill Combo", description: "1x Burger, 1x Medium Fries, 1x Cola Soda, 1x Tomato Souse\nHere you get it all - The full Welm's Grill experience!"),
            SpecialSaleMenuItem(sale: 10, price: 19.99, imageURL: "https://img.freepik.com/free-photo/juicy-chicken-burger-with-fresh-lettuce-crispy-french-fries-wooden-board_181624-50895.jpg?w=740&t=st=1700537979~exp=1700538579~hmac=28d40a83d2b501972bd2f11eb31058d8686dc2d8125aee22e7e94e609b6a7a67", title: "Grandma Dinner", description: "1x Huge Huge Chickenburger!, 1x Large Large Fries!, 1x special portion of strips!, 1x Grandma Salsa Souse, 1x Orange Juise"),
            SpecialSaleMenuItem(sale: 20, price: 20.99, imageURL: "https://img.freepik.com/free-photo/mouth-watering-delicious-sandwiches-fries-chicken-nuggets-black-board-fries-pepper-dark-gray-blurred-surface_179666-42705.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Cheese Peasy", description: "2x Cheeseburger, 1x Large Fries, 2x special strips!"),
            DiscountMenuItem(sale: 15, price: 28.99, imageURL: "https://img.freepik.com/free-photo/high-angle-set-burgers-wooden-board_23-2148290590.jpg?w=740&t=st=1700538078~exp=1700538678~hmac=02a6a28424b525e6f92faed04d22fdca3515a8b5d5d6d73d9333d87a85ced7c8", title: "Triospeciality", description: "3x Chickenburger, 3x Large Fries, 3x Lager Beer. Only for best friends!"),
            DiscountMenuItem(sale: 15, price: 20.05, imageURL: "https://img.freepik.com/free-photo/mini-chicken-meat-burger-cucumber-tomato-lettuce-carrot-cheese-side-view_141793-2795.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Date Tonight", description: "2x Patty Melt, 2x Medium Fries, 2x Apple Tea, special glass with vegetables.\nHere you get it all for you two!")
            ]),
        Menu(imageName: "burgerLogo", title: "Burgers", menuItem: [
            MenuItem(price: 8.05, imageURL: "https://burst.shopifycdn.com/photos/stacked-cheeseburger-on-yellow-background.jpg?width=925&amp;format=pjpg&amp;exif=0&amp;iptc=0", title: "THE BIG TASTY", description: "Beef cheeseburger topped with lettuce and tomato, served on an all-natural sesame seed bun. Our beef burger is cooked medium (pink on the inside), unless requested otherwise."),
            SpecialSaleMenuItem(sale: 10, price: 9.18, imageURL: "https://img.freepik.com/free-photo/front-view-burger-table_23-2148678799.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "BBQ Burger", description: "Beef cheeseburger topped with lettuce, tomato, pickle, onion, ketchup, mayo and Tasty Sauce, served on an all-natural sesame seed bun. Our beef burger is cooked medium (pink on the inside), unless requested otherwise."),
            DiscountMenuItem(sale: 10, price: 9.99, imageURL: "https://img.freepik.com/free-photo/huge-burger-with-fried-meat-vegetables_140725-971.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Cheeseburger", description: "Beef cheeseburger topped with BBQ sauce, sauteed onions and crispy fried onions, served on an all-natural bun. Our beef burger is cooked medium (pink on the inside), unless requested otherwise. This item contains gluten and cannot be modified to be gluten-free."),
            MenuItem(price: 9.18, imageURL: "https://img.freepik.com/free-photo/chicken-burger-with-french-fries-table_140725-4532.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Chickenburger", description: "Beef cheeseburger topped with a fried egg, crispy bacon and Tasty Spicy Ketchup, served on an all-natural sesame seed bun. Our beef burger is cooked medium (pink on the inside), unless requested otherwise"),
            DiscountMenuItem(sale: 10, price: 9.18, imageURL: "https://img.freepik.com/free-photo/hamburger-with-french-fries-table_140725-4745.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Patty Melt", description: "Beef cheeseburger topped with sauteed onions, served on an all-natural sesame seed bun. Our beef burger is cooked medium (pink on the inside), unless requested otherwise.")
            ]),
        Menu(imageName: "friesLogo", title: "Fries", menuItem: [
            MenuItem(price: 4.59, imageURL: "https://img.freepik.com/premium-photo/french-fries-craft-paper-box-wooden-board-top-view-with-copy-space_251318-209.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "French Fries", description: "Good Choise to.."),
            MenuItem(price: 4.59, imageURL: "https://img.freepik.com/free-photo/high-angle-french-fries-paper-with-sauce_23-2148701493.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Village Fries", description: "Good Choise to.."),
            MenuItem(price: 5.59, imageURL: "https://img.freepik.com/premium-photo/fried-forest-chanterelle-mushrooms-with-herbs-wooden-background-top-view_89816-37706.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Fried Potatoes", description: "Good Choise to..")
            ]),
        Menu(imageName: "drinkLogo", title: "Beverages", menuItem: [
            MenuItem(price: 2.85, imageURL: "https://img.freepik.com/free-photo/beautiful-cold-drink-cola-with-ice-cubes_1150-26255.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Cola Soda", description: "1x big glass of cola 400ml."),
            MenuItem(price: 2.85, imageURL: "https://img.freepik.com/premium-photo/drink_920207-1754.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Fanta Soda", description: "1x big glass of fanta 400ml."),
            MenuItem(price: 4.99, imageURL: "https://img.freepik.com/free-photo/glasses-green-apple-healthy-tea-put-fresh-green-apples_1150-34476.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Apple tea", description: "Healthy tea glass from fresh apples and high quality ceylon tea 400ml"),
            DiscountMenuItem(sale: 10, price: 4.05, imageURL: "https://img.freepik.com/free-photo/fresh-orange-juice-glass-dark-background_1150-45560.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Orange juice", description: "Healthy juice glass from fresh oranges 400ml"),
            MenuItem(price: 6.99, imageURL: "https://img.freepik.com/free-photo/front-view-glasses-beer-with-wheat_23-2148755010.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Beer", description: "2x glass of nandmade lager beer 500ml")
            ]),
        Menu(imageName: "souseLogo", title: "Souses", menuItem: [
            MenuItem(price: 1.65, imageURL: "https://img.freepik.com/free-photo/ketchup-tomato-sauce-with-fresh-tomato_1150-38251.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Tomato souse", description: "1x potion of ketchup from fresh tomatoes 50ml"),
            MenuItem(price: 1.65, imageURL: "https://img.freepik.com/premium-photo/barbecue-sauce-bowl-brush-rustic-wooden-table-condiments-herbs_59529-1627.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "BBQ souse", description: "1x portion of BBQ souse 50ml.\nThis is smell like wood burning stove."),
            MenuItem(price: 1.65, imageURL: "https://img.freepik.com/free-photo/red-lentil-soup-disposable-cup-bowl-served-with-green-vegetables_114579-865.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Mustard souse", description: "1x portion of fresh mustard souse 50ml\n Warning! This is russian style spicy mustard for spicy lovers!"),
            MenuItem(price: 3.99, imageURL: "https://img.freepik.com/premium-photo/three-kinds-red-tomato-sauce_136595-10831.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Souse 4", description: "All souses in one order.\nTomato, BBQ and especialy guest - Salsa souse: 50ml 50ml 50ml")
            ])
    ]
}
