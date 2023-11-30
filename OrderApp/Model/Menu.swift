//
//  MenuModel.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import Foundation


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

class DiscountMenuItem: MenuItem {
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
    let description: String
    let menuItem: [MenuItem]
}

extension Menu {
    static let mockData: [Menu] = [
        Menu(imageName: "comboLogo", title: "Combo", description: "Nice food", menuItem: [
            MenuItem(price: 15.99, imageURL: "https://img.freepik.com/premium-photo/fresh-tasty-burger-french-fries-soft-drink-dark-background_113876-3426.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Combo 1", description: "Good Choise to.."),
            MenuItem(price: 16.99, imageURL: "https://img.freepik.com/free-photo/juicy-chicken-burger-with-fresh-lettuce-crispy-french-fries-wooden-board_181624-50895.jpg?w=740&t=st=1700537979~exp=1700538579~hmac=28d40a83d2b501972bd2f11eb31058d8686dc2d8125aee22e7e94e609b6a7a67", title: "Combo 2", description: "Good Choise to.."),
            DiscountMenuItem(sale: 15, price: 20.99, imageURL: "https://img.freepik.com/free-photo/mouth-watering-delicious-sandwiches-fries-chicken-nuggets-black-board-fries-pepper-dark-gray-blurred-surface_179666-42705.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Combo 3", description: "Good Choise to.."),
            MenuItem(price: 13.99, imageURL: "https://img.freepik.com/free-photo/high-angle-set-burgers-wooden-board_23-2148290590.jpg?w=740&t=st=1700538078~exp=1700538678~hmac=02a6a28424b525e6f92faed04d22fdca3515a8b5d5d6d73d9333d87a85ced7c8", title: "Combo 4", description: "Good Choise to.."),
            DiscountMenuItem(sale: 15, price: 19.99, imageURL: "https://img.freepik.com/free-photo/mini-chicken-meat-burger-cucumber-tomato-lettuce-carrot-cheese-side-view_141793-2795.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Combo 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "burgerLogo", title: "Burgers", description: "Nice food", menuItem: [
            MenuItem(price: 11.99, imageURL: "https://burst.shopifycdn.com/photos/stacked-cheeseburger-on-yellow-background.jpg?width=925&amp;format=pjpg&amp;exif=0&amp;iptc=0", title: "Burger 1", description: "Good Choise to.."),
            MenuItem(price: 9.99, imageURL: "https://img.freepik.com/free-photo/front-view-burger-table_23-2148678799.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Burger 2", description: "Good Choise to.."),
            DiscountMenuItem(sale: 10, price: 13.99, imageURL: "https://img.freepik.com/free-photo/huge-burger-with-fried-meat-vegetables_140725-971.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Burger 3", description: "Good Choise to.."),
            MenuItem(price: 11.99, imageURL: "https://img.freepik.com/free-photo/chicken-burger-with-french-fries-table_140725-4532.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Burger 4", description: "Good Choise to.."),
            DiscountMenuItem(sale: 10, price: 10.99, imageURL: "https://img.freepik.com/free-photo/hamburger-with-french-fries-table_140725-4745.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Burger 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "friesLogo", title: "Fries", description: "Nice food", menuItem: [
            MenuItem(price: 5.99, imageURL: "https://img.freepik.com/premium-photo/french-fries-craft-paper-box-wooden-board-top-view-with-copy-space_251318-209.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Fries 1", description: "Good Choise to.."),
            MenuItem(price: 6.99, imageURL: "https://img.freepik.com/free-photo/high-angle-french-fries-paper-with-sauce_23-2148701493.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Fries 2", description: "Good Choise to.."),
            MenuItem(price: 7.99, imageURL: "https://img.freepik.com/premium-photo/fried-forest-chanterelle-mushrooms-with-herbs-wooden-background-top-view_89816-37706.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Fries 3", description: "Good Choise to..")
            ]),
        Menu(imageName: "drinkLogo", title: "Drinks", description: "Nice food", menuItem: [
            MenuItem(price: 3.99, imageURL: "https://img.freepik.com/free-photo/beautiful-cold-drink-cola-with-ice-cubes_1150-26255.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Drink 1", description: "Good Choise to.."),
            MenuItem(price: 5.99, imageURL: "https://img.freepik.com/premium-photo/drink_920207-1754.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Drink 2", description: "Good Choise to.."),
            MenuItem(price: 4.99, imageURL: "https://img.freepik.com/free-photo/glasses-green-apple-healthy-tea-put-fresh-green-apples_1150-34476.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Drink 3", description: "Good Choise to.."),
            DiscountMenuItem(sale: 10, price: 7.99, imageURL: "https://img.freepik.com/free-photo/fresh-orange-juice-glass-dark-background_1150-45560.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Drink 4", description: "Good Choise to.."),
            MenuItem(price: 2.99, imageURL: "https://img.freepik.com/free-photo/front-view-glasses-beer-with-wheat_23-2148755010.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Drink 5", description: "Good Choise to..")
            ]),
        Menu(imageName: "souseLogo", title: "Souses", description: "Nice food", menuItem: [
            MenuItem(price: 2.99, imageURL: "https://img.freepik.com/free-photo/ketchup-tomato-sauce-with-fresh-tomato_1150-38251.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Souse 1", description: "Good Choise to.."),
            MenuItem(price: 2.99, imageURL: "https://img.freepik.com/premium-photo/barbecue-sauce-bowl-brush-rustic-wooden-table-condiments-herbs_59529-1627.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Souse 2", description: "Good Choise to.."),
            MenuItem(price: 3.99, imageURL: "https://img.freepik.com/free-photo/red-lentil-soup-disposable-cup-bowl-served-with-green-vegetables_114579-865.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Souse 3", description: "Good Choise to.."),
            MenuItem(price: 5.99, imageURL: "https://img.freepik.com/premium-photo/three-kinds-red-tomato-sauce_136595-10831.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Souse 4", description: "Good Choise to..")
            ])
    ]
}
