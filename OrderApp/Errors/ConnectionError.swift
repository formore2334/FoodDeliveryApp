//
//  ConnectionError.swift
//  OrderApp
//
//  Created by ForMore on 21/12/2023.
//

import Foundation

// Custom error enum for network connection error
enum ConnectionError: Error, LocalizedError {
    case unavailable
    
    var errorDescription: String? {
        switch self {
        case .unavailable:
            return "Connection lost. Check your network connection"
        }
    }
    
}
