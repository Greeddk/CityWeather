//
//  ViewControllerProtocol.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation

protocol ViewControllerProtocol: AnyObject {
  associatedtype ViewModelType: ViewModelProtocol
  
  var viewModel: ViewModelType { get }
}
