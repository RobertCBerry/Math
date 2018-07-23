//
//  ViewController.swift
//  Math
//
//  Created by Robert Berry on 7/23/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    var number = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action Buttons
    
    @IBAction func clearTextField(_ sender: Any) {
        
        // When the button is tapped the inputTextField will return an empty String and the currency labels will return the String "0.00".
        
        inputTextField.text = ""
        answerLabel.text = ""
    }
    
    @IBAction func squareButton(_ sender: Any) {
        
        self.answerLabel.text = String(square(number: Double(inputTextField.text!)!))
        
    }
    
    @IBAction func CubeButton(_ sender: Any) {
        
        self.answerLabel.text = String(cube(number: Double(inputTextField.text!)!))
    }
    
    
    @IBAction func squareRootButton(_ sender: Any) {
        
        self.answerLabel.text = String(squareRoot(number: Double(inputTextField.text!)!))
    }
    
    // MARK: Helper Methods
    
    func square(number: Double) -> Double {
        
        return pow(number, 2)
    }
    
    func cube(number: Double) -> Double {
        
        return pow(number, 3)
    }
    
    func squareRoot(number: Double) -> Double {
        
        return sqrt(number)
        
    }
    
    // Called when 'return' key is pressed.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    // Called when user taps outside the text field
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
} 

