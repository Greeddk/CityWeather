//
//  UIView+.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ Views: [UIView]) {
        Views.forEach { addSubview($0) }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
