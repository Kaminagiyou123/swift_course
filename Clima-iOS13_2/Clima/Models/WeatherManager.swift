//
//  WeatherManager.swift
//  Clima
//
//  Created by ran you on 1/16/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather:WeatherModel)
    func didFailWithError(error:Error)
}

struct WeatherManager{
    
    var delegate:WeatherViewController?
    
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?units=metric&appid=fe84bedc4e4f076bb06b1778f19a9e77"
    
    func fetchWeather(cityName:String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(url: urlString)
    }
    
    func fetchWeather(latitude:Double,longtitude:Double){
        let urlString = "\(weatherURL)&lon=\(longtitude)&lat=\(latitude)"
        performRequest(url: urlString)
    }
    
    func performRequest(url:String){
        //        1 create url
        if let url = URL(string:url){
            //        2.create session
            let session=URLSession(configuration: .default)
            //        3.create task
            let task=session.dataTask(with: url) {(data:Data?, response:URLResponse?,error:Error?)
                in
                if error != nil {
                    delegate?.didFailWithError(error: error as! Error )
                    return
                }
                if let safeData=data {
                    if let weather = parseJSON(weatherData: safeData){
                        delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            //        4.run task
            task.resume()
        }
        
    }
    
    
    func parseJSON(weatherData:Data) -> WeatherModel?{
        let decoder=JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherId=decodedData.weather[0].id
            let temp=decodedData.main.temp
            let name=decodedData.name
            
            let weather=WeatherModel(conditionId:weatherId, temperature: temp, cityName: name)
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error as! Error)
            return nil
        }
    }
    
    
    
}


