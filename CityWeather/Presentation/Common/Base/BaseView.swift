//
//  BaseView.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setupAttributes()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setHierarchy() { }
    
    func setupLayout() { }
    
    func setupAttributes() { }
    
}
