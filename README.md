# Welm’s Delivery App

This is a sample food delivery app to practice UIKit framework and MVC+C design pattern. 

The main requirements of the project where: 

- Design of various separate layers (Networking Layer, Data Service etc.)
- Implementation of error handling logic
- Practice with Coordinator pattern, Cocoa Pods, Combine.

### How to run

```
> cd WelmsDelivery
> open WelmsDelivery.xcodeproj
```

***
You can check all the possibilities live here:

- [Normal behaviour](https://appetize.io/app/fpdxhpwdawn2pszplhkb4fiupe) 
- [With a simulated error after a few seconds of running the app](https://appetize.io/app/sf3kbzyfccftzgrpminn6mlb54)
***

# Contents

- [App Features](https://github.com/formore2334/WelmsDelivery#app-features)

- [Error Handling](https://github.com/formore2334/WelmsDelivery#app-features)

- [Result type in Swift](https://github.com/formore2334/WelmsDelivery#app-features)

- [Coordinator pattern](https://github.com/formore2334/WelmsDelivery#app-features)

- [Complex data models](https://github.com/formore2334/WelmsDelivery#app-features)

- [Conclusion](https://github.com/formore2334/WelmsDelivery#conclusion)

## App Features

### Start animation

The application greets you with a start animation. The user sees this animation twice: when entering the application and after returning from the final screen.

<img src="https://github.com/formore2334/OrderAppGitTest/blob/main/README_assets/startAnimation.gif?raw=true" width="150" height="290">

### Bad data response

Imagine bad data response when the user launch application. This case shows similar behaviour after a few seconds of running the application.

<img src="https://github.com/formore2334/OrderAppGitTest/blob/main/README_assets/errorScreen.gif?raw=true" width="150" height="290">

### Text validation

This user info form comprises of UITableView where each cell is a separate field for entering user data. Also this table have possibility of entering coupon key word to validate final discount price.

<img src="https://github.com/formore2334/OrderAppGitTest/blob/main/README_assets/textValidation.gif?raw=true" width="150" height="290">

### Different menu groups

Handling of menu groups is a big part of project. Each menu item can be “special”, this depends only on the wishes of the customer.
If menu item is special user sees star next to it, also next in hierarchy controller have “special button” which is only visible for “special” group. And finally all special and regular items are displayed in basket in separate tables 

<div style="display: flex;">
  <img src="https://github.com/formore2334/OrderAppGitTest/blob/main/README_assets/menuDemonstration.gif?raw=true" width="150" height="290" style="margin-right: 10px;">
  <img src="https://github.com/formore2334/OrderAppGitTest/blob/main/README_assets/salesDemontration.gif?raw=true" width="150" height="290">
</div>


## Error Handling

To track an error inside DataService class is set binding variable:

```Swift
@Published var error: Error?
```

After this error handling using Combine framework inside separate ErrorManager class:

```Swift
 // Checks DataService for errors
    private func getError() {
        
        dataService.$error
            .sink { [weak self] newError in
                self?.handleNewError(newError)
            }
            .store(in: &cancellables)
        
    }
```
Into handleNewError method error triggered dataDelegate

And last step in this chain:

Inside the SceneDelegate file is declared:

```Swift
// Tracks loading error
protocol DataDelegate: AnyObject {
    func didReceiveValidData()
    func didReceiveInvalidData()
}
```

Which launches the required controller in window: 

```Swift
   // Setup tab bar controller in window
    func didReceiveValidData() {
        guard let window = window else { return }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.setTabBarController(to: window)
        }, completion: nil)
        
    }
    
    // Setup error controller in window
    func didReceiveInvalidData() {
        guard let window = window else { return }
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.setErrorScreenViewController(to: window)
        }, completion: nil)
        
    }
```

## Result type in Swift

To validate user input used Result type. Inside ValidationManager structure we have set of functions which handle input in accordance with RegexPatterns enum and give the result success or failure. 
If case is failure function return custom error describing from CheckoutListError enum. 
After that error comes into FormContentBuilder where takes its place and finally goes into error label and user can see what wrong with input.

ValidationManager:

```Swift
  // Validation implementation for each pattern
    func validateName(_ text: String) -> Result<String, Error> {
        guard let _ = validateRegex(text: text, pattern: RegexPatterns.name) else {
            let error = customError(errorText: CheckoutListError.name.rawValue)
            return .failure(error)
        }
        
        return .success(text)
    }

Etc.
```

FormContentBuilder:

```Swift
 // Implementation to each case in CheckoutList form
    func updateUserInfo(text: String, for checkoutListItem: CheckoutList, with basket: Basket? = nil) -> (String, Any)? {
        
        switch checkoutListItem {
            
        case .name:
            
            // Validate incoming text
            switch validateManager.validateName(text) {
            case .success(let validText):
                
                // Change UserInfo model
                userInfo.name = validText.capitalized
                return (validText, "")
            case .failure(let errorText):
                userInfo.name = ""
                return ("", errorText.localizedDescription)
            }

Etc.
```

CheckoutListViewController:

```Swift
// Closure from cell which fills user model with the necessary data
        cell.didEnterText = { [weak self] text in
            
            guard let self = self else { return }
            
            // Validate all text fields
            switch checkoutListItem {
                
                // Validate name text field
                // Returns error for error label in this vc
            case .name:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .name) {
                    cell.configureErrorLabel(errorText as? String ?? "")
                }

Etc.
```

## Coordinator pattern

Most interesting part of the project is special menu and interaction with this part. There are three models of menu item in the app globally. And protocol that declares their all standard properties.

 ```Swift
protocol MenuItemProtocol: Identifiable, Decodable {
    var id: Int { get }
    var price: Double { get }
    var imageURL: String { get }
    var title: String { get }
    var description: String { get }
}

struct RegularMenuItem: MenuItemProtocol {
    // some code
}

struct DiscountMenuItem: MenuItemProtocol, Discountable {
    // some code
}

struct SpecialMenuItem: MenuItemProtocol, Discountable {
    // some code
}
```

Special menu items can exist as separate items and also as part of Sales group.

Sales group is UICollectionView at the Home Screen which represent different sales available for user. Sales group divided into two part:

- Sales with information (example: How to get a discount in a cafe at the checkout)
- Sales with sets of menu items which user can add to basket immediately 

For the second case it is used Coordinator pattern which can manage all this hierarchies. Coordinator also sets UITabBarController and manages all its tabs.

Thanks to the coordinator, you can also switch from other screens using a “special button” to the screen of Sales group. (As was described earlier)

```Swift
final class MainCoordinator: Coordinator {
    
    var tabBarController: UITabBarController
    
    // some code
    
    // MARK: - Init
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    // MARK: - Passing data between view's
    
    // Sends regular menuItem to basket
    func passOrderToBasket(menuItem: (any MenuItemProtocol)) {
        // some code
    }
    
    // Sends array of special menuItem's to basket
    func passSpecialOrderToBasket(with specialMenuItems: [SpecialMenuItem], saleID: Int, discountTitle: String) {
       // some code
    }
    
    // Goes to desired sale view controller
    func goToCurrentSale(menuItem: (any MenuItemProtocol)) {
        // some code
    }
     
}
```

## Complex data models

One more interesting thing it is basket model implementation. 

Due to the fact that the user has the ability to add and remove selected items directly from the basket using the plus and minus buttons, this project has implemented a model that allows you to create one array with all items and their quantity.

```Swift
struct BasketItem {
    let menuItem: (any MenuItemProtocol)
    var count: Int
}

struct BasketSpecialItem {
    let saleID: Int
    let discountTitle: String
    let specialMenuItems: [SpecialItem]
    
    struct SpecialItem {
        let menuItem: SpecialMenuItem
        var count: Int
    }
    
    // Returns total sum of all special items
    var totalSum: Double {
       // some code
    }

}

struct Basket {
    var basketItems: [BasketItem]
    var basketSpecialItems: [BasketSpecialItem]
    
    // Returns total count of basket items & basket special items
    var totalCount: Int {
      // some code
    }
    
    // Returns total sum of basket items + basket special items
    var totalSum: Double {
        // some code
    }
    
}
```

All that remains is to add the logic for adding and removing items directly in BasketManager:

```Swift
  //MARK: - Regular & Discount table items adding & deleting logic
    
    // Adds menuItem in basket
    func addItemToBasket(with menuItem: (any MenuItemProtocol)) {
        
        // Finds an existing index in the basket array
        if let existingBasketItemIndex = basket.basketItems.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            
            // Finds an existing regular basketItem
            var basketItem = basket.basketItems[existingBasketItemIndex]
            
            // Adds one to the counter inside BasketItem
            basketItem.count += 1
            
            // Assigns a new value at index
            basket.basketItems[existingBasketItemIndex] = basketItem
        } else {
            
            // Creates a new item and adds it to the end of the array
            let newBasketItem = BasketItem(menuItem: menuItem, count: 1)
            basket.basketItems.append(newBasketItem)
        }
    }

    // Increments item counter in regular basketItems array
    func incrementItemCount(at index: Int) {
        guard index >= 0 else { return }
        
        var basketItem = basket.basketItems[index]
        basketItem.count += 1
        basket.basketItems[index] = basketItem
    }
    
    // Decrements item counter in regular basketItems array
    func decrementItemCount(at index: Int) {
        guard index >= 0 else { return }
        
        var basketItem = basket.basketItems[index]
        basketItem.count -= 1
        if basketItem.count == 0 {
            basket.basketItems.remove(at: index)
        } else {
            basket.basketItems[index] = basketItem
        }
    }
```

And finally, a coordinator is also used to transfer the items to the basket. This demonstrate next coordinator methods:

```Swift
// Sends regular menuItem to basket
    func passOrderToBasket(menuItem: (any MenuItemProtocol)) {
        
        // Finds a basket nav controller in an tab bar controller array
        if let basketNavigationController = tabBarController.viewControllers?[2] as? UINavigationController,
           
            // Creates basketVC from the found controller
           let basketVC = basketNavigationController.viewControllers.first as? BasketViewController {
            
            // Pass data to vc
            basketVC.addItemToBasket(menuItem: menuItem)
        }
        
    }
```

### Conclusion

Now you have seen the main points and design approaches that where used in this project. Of course, you can find more interesting solutions inside the project itself.

***
To see more options with live simulator in your browser follow the link:

- [Normal behaviour](https://appetize.io/app/fpdxhpwdawn2pszplhkb4fiupe) 
- [With a simulated error after a few seconds of running the app](https://appetize.io/app/sf3kbzyfccftzgrpminn6mlb54)
***
