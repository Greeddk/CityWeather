//
//  DailyWeather.swift
//  CityWeather
//
//  Created by Greed on 6/26/24.
//

import Foundation

struct DailyWeather {
    let date: String
    let maxTemp: Double
    let minTemp: Double
    let icon: String
    let currentTemp: Double?
    let main: String?
    let description: String?
    
    init(date: String, maxTemp: Double, minTemp: Double, icon: String, currentTemp: Double? = nil, main: String? = nil, description: String? = nil) {
        self.date = date
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.icon = icon
        self.currentTemp = currentTemp
        self.main = main
        self.description = description
    }
    
    var minCelTemp: String {
        let celsius = minTemp - 273.15
        let roundedCel = Int(round(celsius))
        let result = "최저: " + String(roundedCel) + "°"
        return result
    }
    
    var maxCelTemp: String {
        let celsius = maxTemp - 273.15
        let roundedCel = Int(round(celsius))
        let result = "최고: " + String(roundedCel) + "°"
        return result
    }
    
    var roundedTemp: String {
        let celsius = (currentTemp ?? 300) - 273.15
        let result = Int(round(celsius))
        return String(result) + "°"
    }
}
