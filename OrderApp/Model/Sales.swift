//
//  SalesModel.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import Foundation


struct Sale: Identifiable, Decodable {
    let id: Int
    let previewImageURL: String
    let backgroundImageURL: String
    let title: String
    var textHeadline: String
    var textDescription: String
    var menuItemsID: [Int]? = nil
}

// Creates custom CodingKeys to hanling formatting characters \t, \n from JSON

extension Sale {
    
    private enum CodingKeys: String, CodingKey {
        case id, previewImageURL, backgroundImageURL, title, textHeadline, textDescription
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        previewImageURL = try container.decode(String.self, forKey: .previewImageURL)
        backgroundImageURL = try container.decode(String.self, forKey: .backgroundImageURL)
        title = try container.decode(String.self, forKey: .title)
        textHeadline = try container.decode(String.self, forKey: .textHeadline)
        textDescription = try container.decode(String.self, forKey: .textDescription)
        
        // Replace special formatting characters
        
        let rawTextHeadline = try container.decode(String.self, forKey: .textHeadline)
        textHeadline = rawTextHeadline.replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\t", with: "\t")
        
        let rawTextDescription = try container.decode(String.self, forKey: .textDescription)
        textDescription = rawTextDescription.replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\t", with: "\t")
    }
    
}
