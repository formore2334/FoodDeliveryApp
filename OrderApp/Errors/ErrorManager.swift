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
    
    private var dataService: DataService
    
    private var cancellables = Set<AnyCancellable>()
    
    weak var dataDelegate: DataDelegate?
    
    // MARK: - Init
    
    init(error: Error? = nil,
         dataService: DataService = DataService.shared) {
        self.dataService = dataService
        
        getError()
    }
    
    // MARK: - Methods
    
    // Checks DataService for errors
    private func getError() {
        
        dataService.$error
            .sink { [weak self] newError in
                self?.handleNewError(newError)
            }
            .store(in: &cancellables)
        
    }
    
    // Sets error & launches handle method
    private func handleNewError(_ error: Error?) {
        self.error = error
        
        handleErrorData()
    }

    // Handle error in data
    private func handleErrorData() {
        
        if self.error != nil {
            dataDelegate?.didReceiveInvalidData()
        } else {
            dataDelegate?.didReceiveValidData()
        }
        
        // Post notification about current error condition
        DispatchQueue.main.async { [weak self] in
            NotificationCenter.default.post(name: .errorValueChanged, object: self?.error)
        }
        
    }
    
    // Handle user network connection
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
