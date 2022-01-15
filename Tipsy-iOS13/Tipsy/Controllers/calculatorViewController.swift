//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class calculatorViewController: UIViewController {
    
    var billTotal: Float?
    var tipAmount :Float?
    var splitNumber :Int?
    var result : Float?

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
       
        let tip=sender.currentTitle!
        
        let buttonTitleMinusPercentSign =  String(tip.dropLast())
         tipAmount = Float(buttonTitleMinusPercentSign)!
        
    
     
     
      
    }
    
   
   
    @IBAction func splitNumberChanged(_ sender: UIStepper) {
        splitNumber = Int(sender.value)
        
        splitNumberLabel.text = String(splitNumber ?? 1)
    }
    
    @IBAction func calculateNumber(_ sender: Any) {
        billTotal = Float(billTextField.text ?? "0.0")
        let b = billTotal ?? 0.00
        let t = tipAmount ?? 0.1
        let s = splitNumber ?? 2
        result = b*(1+t)/Float(s)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
      
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            
        let destinationVC=segue.destination as! ResultsViewController
            
            destinationVC.result = Float(result ?? 0.0)
            destinationVC.splitNumber = splitNumber ?? 2
            destinationVC.tipPercentage = tipAmount ?? 0.1
  
        }}
                  
}

