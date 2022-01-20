//
//  WeatherData.swift
//  Clima
//
//  Created by ran you on 1/19/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//
struct Weather:Codable{
    let id:Int
    
}
struct WeatherData:Codable{
    let weather:[Weather]
    let main:Main
    let name:String
  
}

struct Main:Codable{
    let temp:Double
    
}
