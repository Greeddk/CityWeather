//
//  Weather.swift
//  CityWeather
//
//  Created by Greed on 6/24/24.
//

import Foundation

struct Weather: Decodable {
    let weather: [WeatherStatus]
    let main: Temperature
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let name: String?
    let dt_txt: String
    
    static let empty = Weather(
        weather: [],
        main: Temperature(temp: 0.0, feels_like: 0.0, humidity: 0, temp_min: 0.0, temp_max: 0.0),
        visibility: 0,
        wind: Wind(speed: 0.0, deg: 0),
        clouds: Clouds(all: 0),
        name: nil,
        dt_txt: ""
    )
}

struct WeatherStatus: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temperature: Decodable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
    
    var roundedTemp: String {
        let celsius = temp - 273.15
        let result = Int(round(celsius))
        return String(result) + "°"
    }

}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct Clouds: Decodable {
    let all: Int
}
