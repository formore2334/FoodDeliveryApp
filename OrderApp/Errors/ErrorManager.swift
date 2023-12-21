//
//  ErrorManager.swift
//  OrderApp
//
//  Created by ForMore on 21/12/2023.
//

import Foundation
import Reachability
import Combine

class ErrorManager {
    
    var error: Error?
    
    private var dataService = DataService.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    weak var dataDelegate: DataDelegate?
    
    init() {
        
        getError()
    }
    
    // Check DataService for errors
    private func getError() {
        dataService.$error
            .sink { [weak self] newError in
                self?.handleNewError(newError)
            }
            .store(in: &cancellables)
    }
    
    private func handleNewError(_ error: Error?) {
        self.error = error
        
        handleErrorData()
    }

    
    private func handleErrorData() {
        
        if self.error != nil {
            dataDelegate?.didReceiveInvalidData()
        } else {
            dataDelegate?.didReceiveValidData()
        }
        
        DispatchQueue.main.async { [weak self] in
            NotificationCenter.default.post(name: NSNotification.Name("ErrorValueChangedNotification"), object: self?.error)
        }
        
    }
    
    
    private func handleConnectionError() {
        let reachability = try? Reachability()
        
        if let reachability = reachability {
            if reachability.connection == .unavailable {
                self.error = ConnectionError.unavailable
                print("DEBUG:", error ?? "nil")
            } else {
                print("DEBUG: connection ok")
            }
        }
    }
    
    
}
