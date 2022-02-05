//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   @IBOutlet weak var displayLabel: UILabel!
    
   private var isFinishedTypingNumber:Bool = true
   private var displayValue : Double {
        get {
            guard let number = Double(displayLabel.text!)
               else {
                   fatalError("Can not convert display label to a double")
        }
            return number
    }
       set {
           displayLabel.text = String(newValue)
       }
   }
    private var cal = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
       
        isFinishedTypingNumber = true
        
        cal.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = cal.calculate(symbol: calcMethod)  {
                displayValue = result
            }
            
        }
        
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber
            {   displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "."{
            
                    let isInt = floor(displayValue) == displayValue
                    if !isInt {
                        return
                    }
                }
                self.displayLabel.text! += numValue
            }
        }

}
}
