//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calculatorBrain=CalculatorBrain()
    

   
    @IBOutlet weak var heightSlider: UISlider!
    
    @IBOutlet weak var weightSlider: UISlider!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightLabel.text=String(format:"%.2f",sender.value)+"m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel.text=String(format:"%.0f",sender.value)+"Kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
    
        
    self.performSegue(withIdentifier: "goToResults", sender: self)
                                         
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="goToResults"{
            let height=Float(heightSlider.value)
            let weight=Float(weightSlider.value)
            
            let secondVC = segue.destination as! ResultsViewController
            secondVC.bmiValue =  calculatorBrain.calculateBMI(weight: weight, height: height).value
            secondVC.advice=calculatorBrain.getAdvice()
            secondVC.color=calculatorBrain.getColor()
        }
    }
}

