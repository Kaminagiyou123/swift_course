//
//  resultViewController.swift
//  Tipsy
//
//  Created by ran you on 1/15/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var result:Float = 0.0
    var splitNumber=2
    var tipPercentage :Float=0.1

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var noticeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (result)
        print(splitNumber)
        print(tipPercentage)
     
        resultLabel.text = String(format:"%.2f",result)
        noticeLabel.text = "Split between \(splitNumber ) people, with \(Int(tipPercentage*100))% tip"

      
    }
    
    @IBAction func recalculate(_ sender: UIButton) {
        self.dismiss(animated:true, completion:nil)
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
