//
//  City.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation

struct City: Decodable {
    let id: Int
    let name: String
    let lat: Double
    let lon: Double
}
