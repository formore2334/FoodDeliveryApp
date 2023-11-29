//
//  ValidateManager.swift
//  OrderApp
//
//  Created by ForMore on 29/11/2023.
//

import Foundation


struct ValidateManager {

    // Validation implementation for each pattern
    func validateName(_ text: String) -> Result<String, Error> {
        guard let _ = validateRegex(text: text, pattern: RegexPatterns.name) else {
            let error = customError(errorText: CheckoutListError.name.rawValue)
            return .failure(error)
        }
        
        return .success(text)
    }
    
    func validatePhoneNumber(_ text: String) -> Result<String, Error> {
        guard let _ = validateRegex(text: text, pattern: RegexPatterns.phoneNumber) else {
            let error = customError(errorText: CheckoutListError.phone.rawValue)
            return .failure(error)
        }
        
        return .success(text)
    }
    
    func validateEmail(_ text: String) -> Result<String, Error> {
        guard let _ = validateRegex(text: text, pattern: RegexPatterns.emailChars) else {
            let error = customError(errorText: CheckoutListError.email.rawValue)
            return .failure(error)
        }
        
        return .success(text)
    }
    
    func validateAddress(_ text: String) -> Result<String, Error> {
        guard let _ = validateRegex(text: text, pattern: RegexPatterns.higherThanSixChars) else {
            let error = customError(errorText: CheckoutListError.address.rawValue)
            return .failure(error)
        }
        
        return .success(text)
    }
    
    // Custom error description for case .failure
    private func customError(errorText: String) -> NSError {
        NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorText])
    }
    
    // Validate logic
    private func validateRegex(text: String, pattern: String) -> NSTextCheckingResult? {
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: text.count)
            return regex.firstMatch(in: text, range: range)
            
        } catch {
            return nil
        }
        
    }
    
}
