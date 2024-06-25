//
//  CityRepository.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation
import RxSwift

final class CityRepository {
    
    private var cities: [City] = []
    private let list = BehaviorSubject<[City]>(value: [])
    
    init() {
        loadCities()
    }
    
    private func loadCities() {
        guard let url = Bundle.main.url(forResource: "citylist", withExtension: "json") else {
            print("Failed to find JSON file.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            cities = try JsonManager.shared.decode(type: [City].self, data: data)
            list.onNext(cities)
        } catch {
            print("디코딩 에러: \(error)")
        }
    }
    
    func getList() -> Observable<[City]> {
        return list.asObservable()
    }
    
    func filterCity(_ query: String) -> Observable<[City]> {
        return list.map { cities in
            if query.isEmpty {
                return cities
            } else {
                return cities.filter { $0.name.lowercased().contains(query) }
            }
        }
    }
    
}

