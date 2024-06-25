//
//  ViewModelProtocol.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation
import RxSwift

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
