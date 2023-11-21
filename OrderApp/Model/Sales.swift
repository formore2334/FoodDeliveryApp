//
//  SalesModel.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import Foundation


struct Sale {
    let previewImageName: String
    let backgroundImageName: String
    let title: String
    let description: String
}


extension Sale {
    static let mockData: [Sale] = [
        Sale(previewImageName: "https://img.freepik.com/premium-photo/hamburguer-falling-with-all-ingredients-generative-ai_563295-165.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", backgroundImageName: "burgersWaterfallBackground", title: "Burger's waterfall", description: "Your chanse to..."),
        Sale(previewImageName: "https://img.freepik.com/free-photo/delicious-burgers-for-the-us-labor-day_23-2150378683.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765", backgroundImageName: "happyFridayBackground", title: "Happy Friday", description: "Your chanse to..."),
        Sale(previewImageName: "https://img.freepik.com/free-vector/kawaii-fast-food-cute-hamburger-and-drink-illustration_24908-60655.jpg?w=360&t=st=1700539426~exp=1700540026~hmac=1aa5268d4fb6c0fa8b815e9a9dbf4a8486af3c0c8d59c722c6fbbb76d6e9151d", backgroundImageName: "burgersWaterfallBackground", title: "First delivery sale", description: "Your chanse to..."),
        Sale(previewImageName: "https://img.freepik.com/free-photo/juicy-chicken-burger-with-fresh-lettuce-crispy-french-fries-wooden-board_181624-50895.jpg?w=740&t=st=1700537979~exp=1700538579~hmac=28d40a83d2b501972bd2f11eb31058d8686dc2d8125aee22e7e94e609b6a7a67", backgroundImageName: "hotChickenDaysBackground", title: "Hot Chicken Days", description: "Your chanse to..."),
        Sale(previewImageName: "https://img.freepik.com/free-photo/top-view-fish-chips-scattered-surface_23-2148784915.jpg?w=740&t=st=1700539538~exp=1700540138~hmac=852bab5b2ece47223bb7b39b7f1f8b9110c245f30330b95b4a1affb588ca43c4", backgroundImageName: "burgersWaterfallBackground", title: "Strip for step", description: "Your chanse to...")
    ]
}
