//
//  JsonManager.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation

final class JsonManager {
    
    static let shared = JsonManager()
    
    private let decoder = JSONDecoder()
    
    func decode<T: Decodable>(type: T.Type, data: Data) throws -> T {
        return try decoder.decode(type, from: data)
    }
}
