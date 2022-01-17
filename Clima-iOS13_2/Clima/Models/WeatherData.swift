//
//  WeatherData.swift
//  Clima
//
//  Created by ran you on 1/16/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct Main:Codable{
    let temp:Double
}

struct Weather:Codable{
    let description:String
    let id:Int
}

struct WeatherData:Codable{
    let name:String
    let main:Main
    let weather:[Weather]
    
   
}
