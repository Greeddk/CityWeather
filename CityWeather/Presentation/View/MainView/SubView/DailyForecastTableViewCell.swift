//
//  DailyForecastTableViewCell.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit
import SnapKit

final class DailyWeatherForecastTableViewCell: BaseTableViewCell {
    
    private let dayLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let minTemp = UILabel()
    private let maxTemp = UILabel()
    private let divider = Divider()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        contentView.addSubviews([dayLabel, weatherIcon, minTemp, maxTemp, divider])
    }
    
    override func setupLayout() {
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(40)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(50)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(40)
        }
        
        minTemp.snp.makeConstraints { make in
            make.trailing.equalTo(maxTemp.snp.leading).inset(8)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(80)
        }
        
        maxTemp.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.top.equalTo(minTemp)
        }
        
        divider.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        dayLabel.textColor = .white
        minTemp.textColor = .lightGray
        maxTemp.textColor = .white
    }
    
    func configureCell(_ item: DailyWeather) {
        var iconName = item.icon
        if iconName.hasSuffix("n") {
            iconName = String(iconName.dropLast()) + "d"
        }
        weatherIcon.image = UIImage(named: iconName)
        if DateManager.shared.isToday(item.date, format: "yyyy-MM-dd") {
            dayLabel.text = "오늘"
        } else {
            dayLabel.text = DateManager.shared.toString(string: item.date, returnFormat: .day, format: "yyyy-MM-dd")
        }
        maxTemp.text = item.maxCelTemp
        minTemp.text = item.minCelTemp
    }
    
}

