//
//  MyWeatherModel.swift
//  Weather Assignment Exercise
//
//  Created by Jayant on 12/03/22.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let cod: String?
    let cnt: Int?
    let list: [List]?
    let city: City?
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}

// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility, pop: Int?
    let sys: Sys?
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    var getTemperature: String {
        if let temperature = temp {
            return String(format: "%.1f", temperature)
        }
        return ""
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: String?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    var getWeatherType: String {
        if let weatherId = id {
            switch weatherId {
            case 801...804:
                return "cloud.bolt"
            case 800:
                return "sun.max"
            case 701...781:
                return "cloud.fog"
            case 600...622:
                return "cloud.snow"
            case 500...531:
                return "cloud.rain"
            case 300...321:
                return "cloud.drizzle"
            case 200...232:
                return "cloud.bolt"
            default:
                return "cloud"
            }
        }
        else {
            return "cloud"
        }
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
