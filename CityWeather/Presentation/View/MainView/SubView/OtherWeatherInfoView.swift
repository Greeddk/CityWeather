//
//  OtherWeatherInfoView.swift
//  CityWeather
//
//  Created by Greed on 6/26/24.
//

import UIKit
import SnapKit

final class OtherWeatherInfoView: BaseView {

    let humidityBackView = CardView()
    let cloudBackView = CardView()
    let windBackView = CardView()
    let humidityTitle = UILabel()
    let cloudTitle = UILabel()
    let windTitle = UILabel()
    let humidityValue = UILabel()
    let cloudValue = UILabel()
    let windValue = UILabel()
    
    override func setHierarchy() {
        self.addSubviews([humidityBackView, windBackView, cloudBackView])
        humidityBackView.addSubviews([humidityTitle, humidityValue])
        cloudBackView.addSubviews([cloudTitle, cloudValue])
        windBackView.addSubviews([windTitle, windValue])
    }
    
    override func setupLayout() {
        humidityBackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(180)
        }
        cloudBackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(humidityBackView)
            make.size.equalTo(180)
        }
        windBackView.snp.makeConstraints { make in
            make.top.equalTo(humidityBackView.snp.bottom).offset(10)
            make.leading.equalTo(humidityBackView)
            make.size.equalTo(180)
        }
        humidityTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
        }
        humidityValue.snp.makeConstraints { make in
            make.leading.equalTo(humidityTitle)
            make.centerY.equalToSuperview()
        }
        cloudTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
        }
        cloudValue.snp.makeConstraints { make in
            make.leading.equalTo(cloudTitle)
            make.centerY.equalToSuperview()
        }       
        windTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
        }
        windValue.snp.makeConstraints { make in
            make.leading.equalTo(windTitle)
            make.centerY.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        humidityTitle.text = "습도"
        humidityTitle.textColor = .white
        humidityTitle.font = .systemFont(ofSize: 12)
        humidityValue.text = "56%"
        humidityValue.textColor = .white
        humidityValue.font = .systemFont(ofSize: 30)
        cloudTitle.text = "구름"
        cloudTitle.textColor = .white
        cloudTitle.font = .systemFont(ofSize: 12)
        cloudValue.text = "50%"
        cloudValue.textColor = .white
        cloudValue.font = .systemFont(ofSize: 30)
        windTitle.text = "바람 속도"
        windTitle.textColor = .white
        windTitle.font = .systemFont(ofSize: 12)
        windValue.text = "1.97m/s"
        windValue.textColor = .white
        windValue.font = .systemFont(ofSize: 30)
    }
    
    func setUI(humidity: Int, cloud: Int, wind: Double) {
        humidityValue.text = "\(humidity)%"
        cloudValue.text = "\(cloud)%"
        windValue.text = String(format: "%.1f", wind) + "m/s"
    }

}
