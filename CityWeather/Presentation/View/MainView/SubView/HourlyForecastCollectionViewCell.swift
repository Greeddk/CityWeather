//
//  HourlyForecastCollectionViewCell.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit
import SnapKit

final class HourlyForecastCollectionViewCell: BaseCollectionViewCell {
    
    private let timeLabel = UILabel()
    private let weatherImage = UIImageView()
    private let temperatureLabel = UILabel()
    
    override func setHierarchy() {
        contentView.addSubviews([timeLabel, weatherImage, temperatureLabel])
    }
    
    override func setupLayout() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.centerX.equalTo(contentView)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.size.equalTo(40)
            make.centerX.equalTo(contentView)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(4)
            make.centerX.equalTo(contentView)
        }
    }
    
    override func setupAttributes() {
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 16)
        temperatureLabel.textColor = .white
    }
    
    func configureCell(_ item: Weather) {
        guard let weatherStatus = item.weather.first else { return }
        var iconName = weatherStatus.icon
        if iconName.hasSuffix("n") {
            iconName = String(iconName.dropLast()) + "d"
        }
        weatherImage.image = UIImage(named: iconName)
        temperatureLabel.text = item.main.roundedTemp
        timeLabel.text = DateManager.shared.toString(string: item.dt_txt, returnFormat: .ampmHour)
    }
    
}
