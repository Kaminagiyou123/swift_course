//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by ran you on 1/14/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain{
    
    var bmi:BMI?
  
    
    mutating func calculateBMI (weight:Float,height:Float) -> BMI{
        
        let bmiValue=Float(weight/height/height)
        
        if bmiValue<18.5{
            bmi=BMI(value:bmiValue,advice:"Under weight",color:UIColor.blue)
        } else if bmiValue>24.9{
            bmi=BMI(value:bmiValue,advice:"Over weight",color:UIColor.red)
        } else {
            bmi=BMI(value:bmiValue,advice:"normal weight",color:UIColor.green)
        }
        
        return bmi ?? BMI(value:0.0,advice:"error",color:UIColor.clear)
    }
    
    func getAdvice()->String{
        return bmi?.advice ?? "No advice"
    }
    
    func getColor()->UIColor{
        return bmi?.color ?? UIColor.clear
    }
    
    
    
    
}
