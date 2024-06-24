//
//  WeatherForecast.swift
//  CityWeather
//
//  Created by Greed on 6/24/24.
//

import Foundation

struct WeatherForecast: Decodable {
    let list: [Weather]
    let city: City
}
