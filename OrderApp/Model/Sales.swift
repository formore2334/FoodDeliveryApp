//
//  SalesModel.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import Foundation


struct Sale {
    let previewImageURL: String
    let backgroundImageURL: String
    let title: String
    let textHeadline: String
    let textDescription: String
    var menuItems: [MenuItem]? = nil
}



extension Sale {
    static let mockData: [Sale] = [
        Sale(previewImageURL: "https://img.freepik.com/free-vector/beautiful-peace-day-background_23-2147903274.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", backgroundImageURL: "https://img.freepik.com/free-vector/hand-drawn-flat-world-children-s-day-background_23-2149110675.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Safe our kids together", textHeadline: "Buy house of goodness and help children around the world", textDescription: "\tOur work would not be possible without the commitment of our amazing supporters – every house of goodness that you buy counts. When you buy this you are helping to transform the lives of the children we work with.\n\tWe believe that no child should grow up alone. Your sponsorship allows us to provide children with a chance to grow up in a loving family environment.\n\tWe are pays for carers and teachers, school books, uniforms and food as well as healthcare, clean water and building maintenance. It also funds important community projects such as our family strengthening programmes, trauma counselling and psychological support for children who have been through difficult life experiences.\n\t Learn more at https://www.soschildrensvillages.org.uk/"),
        Sale(previewImageURL: "https://img.freepik.com/free-photo/delicious-burgers-for-the-us-labor-day_23-2150378683.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765", backgroundImageURL: "https://img.freepik.com/free-photo/delicious-burgers-us-labor-day_23-2150378698.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", title: "Happy Saturday", textHeadline: "Good day to spend with family", textDescription: "\tThe weekend is the best time for some family fun. Then it’s time to enjoy your time off.\n\tWhether you’re having a quiet weekend at home, looking to get out and about, having a weekend away, or getting on with some projects, we’ve got ideas for you!\n\nWe have espacially suturday offer - Take 3 burgers and save up -50%!", menuItems: [
            Menu.mockData[1].menuItem[1],
            Menu.mockData[1].menuItem[1],
            Menu.mockData[1].menuItem[1]
        ]),
        Sale(previewImageURL: "https://img.freepik.com/free-photo/homemade-newyork-cheesecake-with-frozen-berries-mint-healthy-organic-dessert-top-view_114579-9423.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=ais", backgroundImageURL: "https://img.freepik.com/free-photo/hand-burger-gloves-holding-beef-burger-black-background_140725-303.jpg?size=626&ext=jpg&uid=R126075889&ga=GA1.1.94238438.1700466765&semt=sph", title: "Birthday Especially", textHeadline: "Take our special sweet gift", textDescription: "\tBirthday is the day you feel special\n\n\tAnd only in this day and only you can take this sweet gift from us:)"),
        Sale(previewImageURL: "https://img.freepik.com/free-photo/juicy-chicken-burger-with-fresh-lettuce-crispy-french-fries-wooden-board_181624-50895.jpg?w=740&t=st=1700537979~exp=1700538579~hmac=28d40a83d2b501972bd2f11eb31058d8686dc2d8125aee22e7e94e609b6a7a67", backgroundImageURL: "https://img.freepik.com/free-photo/juicy-chicken-burger-with-fresh-lettuce-crispy-french-fries-wooden-board_181624-50895.jpg?w=740&t=st=1700537979~exp=1700538579~hmac=28d40a83d2b501972bd2f11eb31058d8686dc2d8125aee22e7e94e609b6a7a67", title: "Hot Chicken Days", textHeadline: "Chicken! Chicken! Chicken!", textDescription: "\tSave up -20%! on Combo only with this offer!", menuItems: [
            Menu.mockData[0].menuItem[1],
            Menu.mockData[0].menuItem[2],
        ]),
        Sale(previewImageURL: "https://img.freepik.com/free-photo/top-view-fish-chips-scattered-surface_23-2148784915.jpg?w=740&t=st=1700539538~exp=1700540138~hmac=852bab5b2ece47223bb7b39b7f1f8b9110c245f30330b95b4a1affb588ca43c4", backgroundImageURL: "https://img.freepik.com/free-photo/top-view-fish-chips-scattered-surface_23-2148784915.jpg?w=740&t=st=1700539538~exp=1700540138~hmac=852bab5b2ece47223bb7b39b7f1f8b9110c245f30330b95b4a1affb588ca43c4", title: "Strip for step", textHeadline: "Show how many steps you took today and take your prize!", textDescription: "Launched in 1991, TAFISA World Walking Day has provided a simple and fun way to be physically active and celebrate Sport for All against the global crisis of physical inactivity. Over three decades, millions of people hailing from over a hundred and sixty countries have made a habit of walking together on the first Sunday of October, turning it into “World Walking Day”.\n\tIn 2020, as the world faced a global pandemic disrupting our societies, grassroots sports and health systems, and governments worldwide, we needed to come together and show that the Global Sport for All Movement could stand strong and united during trying times. Thus was born the idea of TAFISA World Walking Day – 24 Hours Around the Globe, the most inclusive and accessible 24-hour relay around the world. TAFISA World Walking Day is the most inclusive and accessible walk around the world.\n\tOver the past three decades, millions of participants have taken part in 160 countries. In 2020, tens of thousands from 65 countries joined us on this new journey, from Antarctica to the westmost confines of the American continent, going through Oceania, Asia, Europe and Africa on the way.\n\n\t This promotion is valid only in our restaurant")
    ]
}
