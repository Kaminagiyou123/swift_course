//
//  WeatherManager.swift
//  Clima
//
//  Created by ran you on 1/19/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didWeatherUpdate(conditionName:String,temperature:Double,city:String)
    func didFailWithError(error:Error)
}


struct WeatherManager {
    var delegate: WeatherViewController?
    
    func fetchWeather(latitude:CLLocationDegrees,longtitude:CLLocationDegrees){
        let urlString="https://api.openweathermap.org/data/2.5/weather?appid=fe84bedc4e4f076bb06b1778f19a9e77&units=metric&lat=\(latitude)&lon=\(longtitude)"
        performRequest(urlString:urlString)
        
    }
    
    func fetchWeather(cityName:String){
        let urlString="https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=fe84bedc4e4f076bb06b1778f19a9e77&units=metric"
        
        performRequest(urlString:urlString)
    }
    func performRequest(urlString: String){
//        1.create URL
        if  let url = URL(string: urlString){
//        2.create session
        let session=URLSession(configuration: .default)
//        3.create task
        let task=session.dataTask(with: url) { (data,response,error) in
           if error != nil{
                delegate?.didFailWithError(error: error!)
            }
            else {
                if let safeData=data{
                    let decoder=JSONDecoder()
                    
                 do   { let decoded = try decoder.decode(WeatherData.self, from: safeData)
                     
                     parseJSON(decoded: decoded)
                 }
                    catch {
                        delegate?.didFailWithError(error: error)
                    }
                
                    func parseJSON(decoded:WeatherData){
                        let conditionId = decoded.weather[0].id
                        let temperature=decoded.main.temp
                        let weatherModel=WeatherModel(conditionId: conditionId)
                        let conditionName=weatherModel.conditionName
                        let city=decoded.name
                       
                        delegate?.didWeatherUpdate(conditionName: conditionName, temperature: temperature, city: city)
                    }
                }
            }
             
        }
            //        4. run task
                    task.resume()
            
        }

       
        
    }

}
