//
//  BaseTableViewCell.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
