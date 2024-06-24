//
//  CWRouter.swift
//  CityWeather
//
//  Created by Greed on 6/24/24.
//

import Foundation
import Alamofire

enum CWRouter {
    case forecast5(city: String)
}

extension CWRouter: Router {
    
    var baseURL: String {
        return APIKey.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .forecast5:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .forecast5:
            return "/forecast"
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .forecast5(let city):
            return [
                Parameters.key.query.rawValue: city,
                Parameters.key.appId.rawValue: APIKey.openWeatherAPIKey,
                Parameters.key.language.rawValue: Parameters.value.korean.rawValue
            ]
        }
    }
    
}
