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
    let country: String
    let coord: Coordinate
    let timezone: Int?
}

struct Coordinate: Hashable, Decodable {
    let lon: Double
    let lat: Double
}
