//
//  ModelData.swift
//  OrderApp
//
//  Created by ForMore on 13/12/2023.
//

import Foundation

final class DataService {
    
    static let shared = DataService()
    
    // Set titles & pictures for each category
    var menu: [Menu] = [
        Menu(id: 100, imageName: "comboLogo", title: "Combo", menuItems: []),
        Menu(id: 200, imageName: "burgerLogo", title: "Burgers", menuItems: []),
        Menu(id: 300, imageName: "friesLogo", title: "Fries", menuItems: []),
        Menu(id: 400, imageName: "drinkLogo", title: "Beverages", menuItems: []),
        Menu(id: 500, imageName: "souseLogo", title: "Souses", menuItems: [])
    ]
    {
        didSet {
            print("Menu has been loaded")
        }
    }
    
    var sales: [Sale] = [] {
        didSet {
            print("Sales has been loaded")
        }
    }
    
    var coupons: [Coupon] = [] {
        didSet {
            print("Coupons has been loaded")
        }
    }
    
    @Published var error: Error?
    
    // MARK: - Init
    
    private init() {
        getMenuData()
        getSalesData()
        getCouponData()
        
        // Error simulation
        simulateErrorBehavior()
    }
    
    // MARK: - Methods
    
    // Fetch all categories of menuItem
    private func getMenuData() {
        
        do {
            let regularMenuItems: [RegularMenuItem] = try load("regularMenuItemsData.json")
            sortMenuItems(with: regularMenuItems)
            self.error = nil
        } catch let error {
            self.error = error
            print(error)
        }
        
        do {
            let discountMenuItems: [DiscountMenuItem] = try load("discountMenuItemsData.json")
            sortMenuItems(with: discountMenuItems)
            self.error = nil
        } catch let error {
            self.error = error
            print(error)
        }
        
        do {
            let specialMenuItems: [SpecialMenuItem] = try load("specialMenuItemsData.json")
            sortMenuItems(with: specialMenuItems)
            self.error = nil
        } catch let error {
            self.error = error
            print(error)
        }
        
    }
    
    // Fetch all sales
    private func getSalesData() {
        do {
            let sales: [Sale] = try load("salesData.json")
            self.sales = sales
            self.error = nil
        } catch let error {
            self.error = error
            print(error)
        }
    }
    
    // Fetch all coupons
    private func getCouponData() {
        do {
            let coupons: [Coupon] = try load("couponsData.json")
            self.coupons = coupons
            self.error = nil
        } catch let error {
            self.error = error
            print(error)
        }
    }
    
    // Sort each category of memuItem to right place in array of menu with id
    private func sortMenuItems<T: MenuItemProtocol>(with menuItems: [T]) {
        
        for menuItem in menuItems {
            
            // Finds a unique code for each menu category which every menuItem has in id
            let idPrefix = Int(String(menuItem.id).prefix(3))
            
            // Fills array of menu with menuItems
            // Each menuItem goes into its own category
            switch idPrefix {
            case 100:
                menu[0].menuItems.append(menuItem)
            case 200:
                menu[1].menuItems.append(menuItem)
            case 300:
                menu[2].menuItems.append(menuItem)
            case 400:
                menu[3].menuItems.append(menuItem)
            case 500:
                menu[4].menuItems.append(menuItem)
            default:
                break
            }
            
        }
        
    }
    
    // Generic loading function for internal json data files
    private func load<T: Decodable>(_ filename: String) throws -> T {
        let data: Data
        
        // Looking for files in main bundle
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw DataError.fileNotFound(filename)
        }
        
        // Trying to pull out data from file
        do {
            data = try Data(contentsOf: file)
        } catch {
            throw DataError.fileLoadFailed(filename, error)
        }
        
        // Trying to decoding this data
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DataError.parsingFailed(filename, error)
        }
        
    }
    
    
}

// MARK: - Error behavior

// Simulation logic of error response just for demonstration error handling
private extension DataService {
    
    // Makes requests every 4 second
    func simulateErrorBehavior() {
        var repeatsCounter = 0
        
        let _ = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] timer in
            self?.checkErrorResponse()
            
            repeatsCounter += 1
            
            if repeatsCounter == 2 {
                timer.invalidate()
            }
        }
        
    }
    
    // Makes error with invalid name of json file
    func checkErrorResponse() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self = self else { return }
            do {
                let sales: [Sale] = try self.load("invalidJSONFileName.json")
                self.sales = sales
                self.error = nil
            } catch let error {
                self.error = error
                print(error)
            }
        }
        
        // return to normaly state
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) { [weak self] in
            guard let self = self else { return }
            do {
                let sales: [Sale] = try self.load("salesData.json")
                self.sales = sales
                self.error = nil
            } catch let error {
                self.error = error
                print(error)
            }
        }
        
    }
    
}
