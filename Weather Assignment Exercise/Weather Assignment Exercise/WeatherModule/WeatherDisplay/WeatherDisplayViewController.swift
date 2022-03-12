//
//  WeatherDisplayViewController.swift
//  Weather Assignment Exercise
//
//  Created by Jayant on 12/03/22.
//

import UIKit
import CoreLocation

class WeatherDisplayViewController: UIViewController {
    
    // MARK: @IBOutlet & Properties
    @IBOutlet weak var imgViewCondition: UIImageView!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblFeelsLike: UILabel!
    @IBOutlet weak var lblHumadity: UILabel!
    
    var weatherDetails: List?
    var cityName: String?
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalizeUI()
    }
    
    //MARK: Custom Methods
    func setData(weatherResponse: List?, cityName:String?) {
        self.weatherDetails = weatherResponse
        self.cityName = cityName
    }
    
    private func initalizeUI() {
        
        title = cityName ?? "My City"
        if let weatherData = weatherDetails {
            lblTemperature.text = weatherData.main?.getTemperature
            lblHumadity.text = "\(weatherData.main?.humidity ?? 0) %rh"
            lblFeelsLike.text = "\(weatherData.main?.feelsLike ?? 0.0)"
            lblCity.text = cityName
            self.imgViewCondition.image = UIImage(systemName: weatherData.weather?.first?.getWeatherType ?? "sun.max")
        }
    }
}
