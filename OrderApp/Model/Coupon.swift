//
//  Coupon.swift
//  OrderApp
//
//  Created by ForMore on 22/11/2023.
//

import Foundation

struct Coupon {
    let title: String
    let imageURL: String
    let description: String
    let discountKeyWord: String
    let discountValue: Int
}

extension Coupon {
    static let mockData = [
        Coupon(title: "Three for two", imageURL: "https://img.freepik.com/free-vector/kawaii-fast-food-cute-hamburger-and-drink-illustration_24908-60655.jpg?w=360&t=st=1700539426~exp=1700540026~hmac=1aa5268d4fb6c0fa8b815e9a9dbf4a8486af3c0c8d59c722c6fbbb76d6e9151d", description: "Three for the price of two", discountKeyWord: "THREE", discountValue: 0),
        Coupon(title: "First Order", imageURL: "https://img.freepik.com/free-vector/kawaii-fast-food-cute-hamburger-and-drink-illustration_24908-60655.jpg?w=360&t=st=1700539426~exp=1700540026~hmac=1aa5268d4fb6c0fa8b815e9a9dbf4a8486af3c0c8d59c722c6fbbb76d6e9151d", description: "10% on the all basket", discountKeyWord: "FRST", discountValue: 10),
        Coupon(title: "Last February Day", imageURL: "https://img.freepik.com/free-vector/kawaii-fast-food-cute-hamburger-and-drink-illustration_24908-60655.jpg?w=360&t=st=1700539426~exp=1700540026~hmac=1aa5268d4fb6c0fa8b815e9a9dbf4a8486af3c0c8d59c722c6fbbb76d6e9151d", description: "15% in last winter day", discountKeyWord: "LAST", discountValue: 15),
        Coupon(title: "Follow me Follow you", imageURL: "https://img.freepik.com/free-vector/kawaii-fast-food-cute-hamburger-and-drink-illustration_24908-60655.jpg?w=360&t=st=1700539426~exp=1700540026~hmac=1aa5268d4fb6c0fa8b815e9a9dbf4a8486af3c0c8d59c722c6fbbb76d6e9151d", description: "Free burger for subscription", discountKeyWord: "Follow", discountValue: 0),
        Coupon(title: "Happy Birthday", imageURL: "https://img.freepik.com/free-vector/kawaii-fast-food-cute-hamburger-and-drink-illustration_24908-60655.jpg?w=360&t=st=1700539426~exp=1700540026~hmac=1aa5268d4fb6c0fa8b815e9a9dbf4a8486af3c0c8d59c722c6fbbb76d6e9151d", description: "15% on all basket in your birthday", discountKeyWord: "THREE", discountValue: 15),
    ]
}
