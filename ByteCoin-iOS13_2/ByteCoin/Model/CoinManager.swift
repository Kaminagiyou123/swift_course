//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdatePrice(currency:String,price:Double)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5B96E782-010C-42E4-8DA4-2D53A97EB3B0"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: ViewController?
    
    func getCoinPrice(for currency:String){
        let urlString="\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        performRequest(urlString: urlString)
        
        func performRequest(urlString:String){
            //        1.create URL
            if let url=URL(string: urlString){
                //        2.create session
                let session=URLSession(configuration: .default)
                //        3.create task
                let task=session.dataTask(with: url) { (data,response,error) in
                    if error != nil{
                        print(error)
                    }
                    if let safeData = data {
                        let price=parseJSON(data: safeData)
                        print(price)
                        print(currency)
                        self.delegate?.didUpdatePrice(currency: currency, price: price ??  0.00)
                        
                        func parseJSON(data:Data)->Double?{
                            let decoder=JSONDecoder()
                            do {let decoded=try decoder.decode(CoinData.self, from: safeData)
                                print(Double(decoded.rate))
                                return Double(decoded.rate)
                            }
                            catch{
                                print(error)
                                return nil
                            }
                        }
                    }
                }
                //           4.start task
                task.resume()
            }
            
        }
        
    }
    
}
