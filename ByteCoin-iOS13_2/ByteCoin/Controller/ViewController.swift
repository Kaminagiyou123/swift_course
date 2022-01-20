//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var coinManager = CoinManager()
    

    @IBOutlet weak var byteCoinPriceLabel: UILabel!
    @IBOutlet weak var currencySignLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate=self
        coinManager.delegate=self
        
        
    }
    
}

extension ViewController: UIPickerViewDataSource{
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension ViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency=coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currency)
    }
    
}

extension ViewController:CoinManagerDelegate{
    func didUpdatePrice(currency: String, price: Double) {
        DispatchQueue.main.async{
            self.currencySignLabel.text=currency
            self.byteCoinPriceLabel.text = String(format:"%.1f",price)
        }
    
    }
    
    
}
