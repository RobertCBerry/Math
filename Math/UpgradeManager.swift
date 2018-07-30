//
//  UpgradeManager.swift
//  Math
//
//  Created by Robert Berry on 7/30/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit
import StoreKit

class UpgradeManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    // MARK: Properties
    
    static let sharedInstance = UpgradeManager()
    
    // Product identifier for in app purchase (IAP) that is set in the App Store Connect.
    
    let productIdentifier = "com.berryenterprises.Math.SquareRootProduct"
    
    typealias SuccessHandler = (_ succeeded: Bool) -> (Void)
    
    var upgradeCompletionHandler: SuccessHandler?
    
    var restoreCompletionHandler: SuccessHandler?
    
    var priceCompletionHandler: ((_ price: Float) -> Void)?
    
    // Object represents SquareRootProduct that was previously registered in iTunes Connect.
    
    var squareRootProduct: SKProduct?
    
    let userDefaultsKey = "HasUpgradedUserDefaultsKey"
    
    // MARK: Action Methods
    
    // Method returns a boolean value to indicate whether the user has upgraded or not.
    
    func hasUpgraded() -> Bool {
        
        // Returns a boolean value for the specified user defaults key.
        
        return UserDefaults.standard.bool(forKey: userDefaultsKey)
    }
    
    // Method for when a user upgrades account.
    
    func upgrade(_ success: @escaping SuccessHandler) {
        
        upgradeCompletionHandler = success
        
        // Adds self as an observer for updates that happen to the payment queue.
        
        SKPaymentQueue.default().add(self)
        
        // Conditional checks if the SKProduct is the squareRootProduct.
        
        if let product = squareRootProduct {
            
            // A request to the app store to process payment for additional functionality.
            
            let payment = SKPayment(product: product)
            
            // Adds a payment request to the queue.
            
            SKPaymentQueue.default().add(payment)
        }
    }
    
    // Method that will restore the purchase of the app for users that previously purchased the app, but are now using the app on a different device or have reinstalled the app.
    
    func restorePurchases(_ success: @escaping SuccessHandler) {
        
        restoreCompletionHandler = success
        
        // Adds self as an observer for updates that happen to the payment queue.
        
        SKPaymentQueue.default().add(self)
        
        // Asks the payment queue to restore previouly completed purchases.
        
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // Method asynchronously returns the price of the app to be displayed in the UpgradeViewController.
    
    func priceForUpgrade(_ success: @escaping (_ price: Float) -> Void) {
        
        priceCompletionHandler = success
        
        // Sets the product identifier that will be requested.
        
        let identifiers: Set<String> = [productIdentifier]
        
        // Retrieves information from the app store about a specified list of products.
        
        let request = SKProductsRequest(productIdentifiers: identifiers)
        
        // Sets the delegate that receives the response of the products request.
        
        request.delegate = self
        
        // Sends request to Apple Store.
        
        request.start()
    }
    
    // MARK: SKPaymentTransactionObserver
    
    // Method notifies about updated transactions in the payment queue.
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            // Switches depending on the current state of the transaction.
            
            switch transaction.transactionState {
                
                // The app store successfully processed payment.
                
            case .purchased:
                
                // Sets userDefaultsKey for if the consumer has purchased the app to true if a purchase has been completed.
                
                UserDefaults.standard.set(true, forKey: userDefaultsKey)
                
                upgradeCompletionHandler?(true)
                
                // This transaction restores content previously purchased by the user.
                
            case .restored:
                
                UserDefaults.standard.set(true, forKey: userDefaultsKey)
                
                restoreCompletionHandler?(true)
                
                // The transaction failed.
                
            case .failed:
                
                upgradeCompletionHandler?(false)
                
            default:
                
                return
            }
            
            // Completes a pending transaction and removes it from the payment queue.
            
            SKPaymentQueue.default().finishTransaction(transaction)
        }
    }
    
    // MARK: SKProductsRequestDelegate
    
    // Method is called when the SKProductsRequest has been completed.
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        // Returns the first product from the SKProductsResponse.
        
        squareRootProduct = response.products.first
        
        // Code unwraps the price of the squareRootProduct and passes that to the priceCompletionHandler.
        
        if let price = squareRootProduct?.price {
            
            priceCompletionHandler?(Float(truncating: price))
        }
    }

}
