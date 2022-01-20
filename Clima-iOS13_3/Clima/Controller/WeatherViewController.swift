//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController,UITextFieldDelegate {
    var weatherManager=WeatherManager()
    var locationManager=CLLocationManager()
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate=self
        weatherManager.delegate=self
        
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func locationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder="Please type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text{
            cityLabel.text=cityName
            weatherManager.fetchWeather(cityName: cityName)
        }
            
        textField.text=""
    
    }

}

extension WeatherViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didWeatherUpdate(conditionName:String,temperature:Double,city:String) {
        DispatchQueue.main.async {
          
            self.temperatureLabel.text = String(format:"%.1f",temperature)
            self.conditionImageView.image = UIImage(systemName: conditionName)
            self.cityLabel.text=city
        }
    }
    
}

extension WeatherViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let location=locations.last{
            let lat=location.coordinate.latitude
            let long=location.coordinate.longitude
         
            weatherManager.fetchWeather(latitude:lat,longtitude:long)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}
