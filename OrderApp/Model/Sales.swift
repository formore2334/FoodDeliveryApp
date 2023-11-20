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
        Sale(previewImageName: "burgersWaterfallPreview", backgroundImageName: "burgersWaterfallBackground", title: "Burger's waterfall", description: "Your chanse to..."),
        Sale(previewImageName: "happyFridayPreview", backgroundImageName: "happyFridayBackground", title: "Happy Friday", description: "Your chanse to..."),
        Sale(previewImageName: "firstDeliverySalePreview", backgroundImageName: "burgersWaterfallBackground", title: "First delivery sale", description: "Your chanse to..."),
        Sale(previewImageName: "hotChickenDaysPreview", backgroundImageName: "hotChickenDaysBackground", title: "Hot Chicken Days", description: "Your chanse to..."),
        Sale(previewImageName: "stripForStepPreview", backgroundImageName: "burgersWaterfallBackground", title: "Strip for step", description: "Your chanse to...")
    ]
}
