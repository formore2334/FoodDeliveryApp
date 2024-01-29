//
//  NetworkManager.swift
//  OrderApp
//
//  Created by ForMore on 20/11/2023.
//

import UIKit


final class NetworkManager {
    
    // Handle network response, returnes UIImage
    private func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode <= 300 else {
            return nil
        }
        
        return image
    }
    
    // Loading image from network
    func fetchImage(url: URL, completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        
        .resume()
    }
    
    // Loading data from network
    func fetchData(url: URL, completionHandler: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode <= 300 else {
                return completionHandler(nil, error)
            }
            
            completionHandler(data, nil)
        }
        
        .resume()
    }
    
}
