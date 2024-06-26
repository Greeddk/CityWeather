//
//  MainView.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit
import SnapKit

final class MainView: BaseView {

    private let backImageView = UIImageView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let searchBar = SearchButton()
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let maxMinTempLabel = UILabel()
    let hourlyView = HourlyForecastView()
    let dailyView = DailyForecastView()
    let mapView = CWMapView()
    let otherInfoView = OtherWeatherInfoView()
    
    override func setHierarchy() {
        self.addSubviews([backImageView, scrollView])
        scrollView.addSubview(contentView)
        contentView.addSubviews([searchBar, cityLabel, temperatureLabel, descriptionLabel, maxMinTempLabel, hourlyView, dailyView, mapView, otherInfoView])
    }
    
    override func setupLayout() {
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.verticalEdges.equalTo(scrollView)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        maxMinTempLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        hourlyView.snp.makeConstraints { make in
            make.top.equalTo(maxMinTempLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(130)
        }
        
        dailyView.snp.makeConstraints { make in
            make.top.equalTo(hourlyView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(260)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(dailyView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(350)
        }
        
        otherInfoView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(350)
            make.bottom.equalToSuperview()
        }
        
    }
    
    override func setupAttributes() {
        backImageView.image = UIImage(named: "sunny")
        cityLabel.font = .systemFont(ofSize: 28)
        cityLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 60)
        temperatureLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 22)
        descriptionLabel.textColor = .white
        maxMinTempLabel.font = .systemFont(ofSize: 16)
        maxMinTempLabel.textColor = .white
    }
    
    func setCurrentWeather(_ item: DailyWeather) {
        guard let main = item.main else { return }
        if main == "Clouds" {
            backImageView.image = UIImage(named: "clouds")
        } else if main == "Rain" {
            backImageView.image = UIImage(named: "rain")
        } else if main == "Fog" {
            backImageView.image = UIImage(named: "fog")
        } else {
            backImageView.image = UIImage(named: "sunny")
        }
        
        temperatureLabel.text = item.roundedTemp
        descriptionLabel.text = item.description ?? ""
        maxMinTempLabel.text = "\(item.maxCelTemp) | \(item.minCelTemp)"
    }
    
    func setCityLabel(_ item: City) {
        cityLabel.text = item.name
    }
    
    func scrollToLeft() {
        if hourlyView.collectionView.numberOfItems(inSection: 0) > 0 {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            hourlyView.collectionView.scrollToItem(at: firstIndexPath, at: .left, animated: false)
        }
    }

}
