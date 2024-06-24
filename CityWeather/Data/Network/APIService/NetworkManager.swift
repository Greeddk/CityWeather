//
//  NetworkManager.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    private let session = Session()
    
    func callRequest<T: Decodable>(router: Router, of type: T.Type) -> Single<T> {
        return Single.create { single in
            let request = self.session.request(router)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let success):
                        single(.success(success))
                    case .failure(let error):
                        if let afError = error.asAFError {
                            let networkError = self.mapError(afError)
                            single(.failure(networkError))
                        } else {
                            single(.failure(NetworkError.unknown))
                        }
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func mapError(_ error: AFError) -> NetworkError {
        guard let statusCode = error.responseCode else {
            return .unknown
        }
        return NetworkError(rawValue: statusCode) ?? .unknown
    }
}
