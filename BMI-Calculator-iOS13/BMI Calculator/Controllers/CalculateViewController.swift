//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    var calculatorBrain=CalculatorBrain()
    
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightLabel.text=String(format: "%.2f", sender.value)+"m"
    }
    
    @IBAction func weightSliderChanged(_ sender:
                                       UISlider) {
        weightLabel.text = String(format: "%.0f", sender.value)+"Kg"
    }
    
    
    @IBAction func calculateBMI(_ sender: UIButton) {
        calculatorBrain.calculateBMI(height:weightSlider.value,weight:heightSlider.value)
        
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
       
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.adviceValue=calculatorBrain.getAdviceValue()
    
        }
    }
    
}

