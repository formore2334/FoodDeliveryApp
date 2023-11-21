//
//  NetworkManager.swift
//  OrderApp
//
//  Created by ForMore on 20/11/2023.
//

import UIKit



class NetworkManager {
    
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
    
    func fetchImage(url: URL, completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    
}
