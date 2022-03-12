//
//  CityInputViewModel.swift
//  Weather Assignment Exercise
//
//  Created by Jayant on 12/03/22.
//

import Foundation
import CoreLocation

//MARK: - WeatherDisplayProtocol
protocol CityInputProtocol : AnyObject {
    func showLoader()
    func hideLoader()
    func showAlertMsg(msg:String)
    func didUpdateWeather(weather: WeatherModel)
}

class CityInputViewModel {
    
    //MARK: - delegate
    weak var delegate:CityInputProtocol?
    
    private let apiKey = "65d00499677e59496ca2f318eb68c049"
    //private let weatherURL = "https://api.openweathermap.org/data/2.5/forecast/hourly"
    private let weatherURL = "https://api.openweathermap.org/data/2.5/forecast"
    
    func fetchWeather(city: String?){
        if let cityName = city, !cityName.isEmpty {
            let urlString = "\(weatherURL)?q=\(cityName)&appid=\(apiKey)&units=metric"
            performRequest(with: urlString)
        }
        else {
            delegate?.showAlertMsg(msg: "Please Enter City Name")
        }
    }
    
    func fetchWeather(latitude lat: CLLocationDegrees, longitude lon: CLLocationDegrees) {
        let urlString = "\(weatherURL)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.showLoader()
        }
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.hideLoader()
                }
                
                if error != nil {
                    self?.delegate?.showAlertMsg(msg: error?.localizedDescription ?? "Oops Something went wrong.")
                    return
                }
                if let weatherData = data {
                    if let weatherResponse = self?.parseJSON(weatherData){
                        
                        if weatherResponse.cod == "200" {
                            self?.delegate?.didUpdateWeather(weather: weatherResponse)
                        }
                        else {
                            self?.delegate?.showAlertMsg(msg: "City Not Found")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherModel.self, from: weatherData)
            debugPrint(decodedData)
            return decodedData
        } catch {
            print(String(describing: error))
            delegate?.showAlertMsg(msg: error.localizedDescription)
            return nil
        }
    }
}
