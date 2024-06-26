//
//  CityTableViewCell.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit
import SnapKit

final class CityTableViewCell: BaseTableViewCell {

    private let city = UILabel()
    private let nation = UILabel()
    
    override func setHierarchy() {
        contentView.addSubviews([city, nation])
    }
    
    override func setupLayout() {
        city.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(contentView).offset(20)
        }
        nation.snp.makeConstraints { make in
            make.top.equalTo(city.snp.bottom).offset(4)
            make.leading.equalTo(city)
            make.bottom.equalTo(contentView).offset(-8)
        }
    }
    
    override func setupAttributes() {
        city.textColor = .white
        city.font = .boldSystemFont(ofSize: 20)
        nation.textColor = .white
        nation.font = .systemFont(ofSize: 16)
    }
    
    func configureCell(_ item: City) {
        city.text = item.name
        nation.text = item.country
    }

}
