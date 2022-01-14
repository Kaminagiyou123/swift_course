//
//  ResultsViewController.swift
//  BMI Calculator
//
//  Created by ran you on 1/13/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    var bmiValue:String?
    var adviceValue:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BMILabel.text = bmiValue
        adviceLabel.text=adviceValue
    }
    
    var calculateVC = CalculateViewController()
    
    @IBAction func recalculateButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion:nil)
      
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
