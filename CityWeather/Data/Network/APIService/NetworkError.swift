//
//  NetworkError.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation

enum NetworkError: Int, Error {
    case unknown = 0
    case unauthorized = 401
    case notFound = 404
    case overcall = 429
    case serverError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    
    var description: String {
        switch self {
        case .unknown:
            return "알 수 없는 오류입니다."
        case .unauthorized:
            return "인증되지 않은 접근입니다. API 키를 확인해주세요."
        case .notFound:
            return "요청한 도시를 찾을 수 없습니다."
        case .overcall:
            return "API 호출 한도를 초과했습니다."
        case .serverError:
            return "서버에서 에러가 발생했습니다. 잠시 후 다시 요청해주세요."
        case .badGateway:
            return "서버 간 통신 문제가 발생하였습니다."
        case .serviceUnavailable:
            return "현재 서비스 이용이 불가능합니다."
        }
    }
}
