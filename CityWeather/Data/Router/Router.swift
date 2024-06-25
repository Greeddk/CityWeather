//
//  Router.swift
//  CityWeather
//
//  Created by Greed on 6/24/24.
//

import Foundation
import Alamofire

protocol Router: URLRequestConvertible {
    
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Alamofire.Parameters? { get }
}

extension Router {
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        let urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
