//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by ran you on 1/13/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
struct CalculatorBrain {
    
    var bmiValue="0.0"
    var adviceValue = "unknown"
    
    mutating func calculateBMI(height:Float,weight:Float){
        let bmi=height/pow(weight,2)
    
        bmiValue = String(format:"%.1f",bmi)
        
        if bmi<=20{
            adviceValue="Get Some Snack"
        }
        else if bmi<=24{
            adviceValue="You look good"
        }
        else {
            adviceValue="Please exercise"
        }
        
        
        
    }
    
    func getBMIValue() -> String {
        return bmiValue
    }
    
    func getAdviceValue()->String{
       return adviceValue
       
    }

    
    
}

