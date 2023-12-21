//
//  DataError.swift
//  OrderApp
//
//  Created by ForMore on 19/12/2023.
//

import Foundation


enum DataError: Error, LocalizedError, CustomDebugStringConvertible {
    case fileNotFound(String)
    case fileLoadFailed(String, Error)
    case parsingFailed(String, Error)
    
    // User description
    var errorDescription: String? {
        switch self {
        case .fileNotFound(_):
            return "There was an error with the server. Please try again later"
        case .fileLoadFailed(_, _):
            return "There was an error with the server. Please try again later"
        case .parsingFailed(_, _):
            return "There was an error with the server. Please try again later"
        }
    }
    
    // Debug description
    var debugDescription: String {
        switch self {
        case .fileNotFound(let filename):
            return "Couldn't find \(filename) in the main bundle."
        case .fileLoadFailed(let filename, let error):
            return "Couldn't load \(filename) from the main bundle:\n\(error)"
        case .parsingFailed(let filename, let error):
            return "Couldn't parse \(filename) as expected type:\n\(error)."
        }
    }
   
}
