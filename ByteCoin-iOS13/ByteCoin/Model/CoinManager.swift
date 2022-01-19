//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didGetCoinPrice(price:Double?,currency:String)
}

struct CoinManager {
    var delegate:ViewController?

    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5B96E782-010C-42E4-8DA4-2D53A97EB3B0"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func getCoinPrice(for currency:String){
        let urlString="\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
//        1.create url
        if let url = URL(string: urlString) {
//        2.create session
        let session = URLSession(configuration: .default)
//        3.set up task
        let task = session.dataTask(with: url) { (data,response,error) in
            if error != nil {
                print (error)
                return
            }
            if let safeData = data{
                let price = parseJSON(data: safeData)
                delegate?.didGetCoinPrice(price:price,currency:currency)
            }
            
            func parseJSON(data: Data)-> Double?{
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(CoinData.self,from:data)
                    let price = decodedData.rate
                    return price
                 
                } catch{
                    print(error)
                    return nil
                }
            }
           
        }
//        4.run task
        task.resume()
    }
        

    }
   
    
}
