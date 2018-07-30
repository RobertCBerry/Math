//
//  UpgradeViewController.swift
//  Math
//
//  Created by Robert Berry on 7/30/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class UpgradeViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var upgradeButton: UIButton!
    
    @IBOutlet weak var restorePurchaseButton: UIButton!
    
    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpgradeManager.sharedInstance.priceForUpgrade { (price) in
            self.priceLabel.text = "$\(price)"
            self.upgradeButton.isEnabled = true
            self.restorePurchaseButton.isEnabled = true
        }
    }
    
    // MARK: Action Methods
    
    // Method is called when the done button is tapped.
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        // Dismisses the view controller that was presented by the previous view controller.
        
        dismiss(animated: true, completion: nil)
    }
    
    // Method is called when the upgrade button is tapped.
    
    @IBAction func upgradeButtonTapped(_ sender: Any) {
        
        UpgradeManager.sharedInstance.upgrade { (succeeded) -> (Void) in
            
            if succeeded {
                
                // Adds alert controller to the view.
                
                let alertController = UIAlertController(title: "Upgraded!", message: "Thank you for upgrading. You can now calculate the square roots of numbers.", preferredStyle: .alert)
                
                // Adds alert action.
                
                let doneAction = UIAlertAction(title: "Done", style: .default, handler: { (action) in
                    
                    self.dismiss(animated: true, completion: nil)
                })
                
                // Adds alert action to the alert controller.
                
                alertController.addAction(doneAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // Method is called when the restore purchase button is tapped.
    
    @IBAction func restorePurchaseButtonTapped(_ sender: Any) {
        
        UpgradeManager.sharedInstance.restorePurchases { (succeeded) -> (Void) in
            
            if succeeded {
                
                let alertController = UIAlertController(title: "Restored!", message: "Your purchases have been restored. You can now calculate the square roots of numbers.", preferredStyle: .alert)
                
                let doneAction = UIAlertAction(title: "Done", style: .default, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
                
                alertController.addAction(doneAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
