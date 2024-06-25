//
//  BaseCollectionViewCell.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setHierarchy()
        setupLayout()
        setupAttributes()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() { }
    
    func setupLayout() { }
    
    func setupAttributes() { }
    
}
