//
//  CityRepository.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation

final class CityRepository {
    
    private var cities: [City] = []
    
    init() {
        
    }
    
    private func loadCities() {
        guard let url = Bundle.main.url(forResource: "citylist", withExtension: "json") else {
            print("Failed to find JSON file.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            cities = try JsonManager.shared.decode(type: [City].self, data: data)
        } catch {
            print("디코딩 에러: \(error)")
        }
    }
    
    func getList() -> [City] {
        return cities
    }
    
    func getCity(name: String) -> City? {
        return cities.first { $0.name == name }
    }
    
}
