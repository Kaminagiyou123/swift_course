//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let softTime=1
    let mediumTime=7
    let hardTime=12
    var cookTime=0
   

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness =  sender.currentTitle!
        progressBar.progress=1.0
        
        
        switch hardness {
        case "Soft":
            cookTime=softTime
        case "Medium":
            cookTime=mediumTime
        case "Hard":
            cookTime=hardTime
        default:
            print("error")
        }
        
        var secondsPassed = 0
        
        let totalTime=60*cookTime
        
   
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
               if secondsPassed < totalTime{
                   let percentagePassed =  Float(secondsPassed) / Float(totalTime)
                   progressBar.progress=Float(percentagePassed)
                
                   print ("\(secondsPassed) seconds passed out of \(totalTime) seconds")
    
                   
                   secondsPassed += 1
               } else {
                   Timer.invalidate()
                   titleLabel.text="DONE!"
                   
                   
               }
        
    
    }
    

   
        


    }

}
