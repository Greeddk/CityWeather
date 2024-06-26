//
//  DailyForecastView.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit
import SnapKit

final class DailyForecastView: BaseView {

    private let backgroundView = CardView()
    private let containerView = UIView()
    private let headerLabel = UILabel()
    private let divider = Divider()
    let tableView = UITableView()
    
    override func setHierarchy() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(containerView)
        containerView.addSubviews([headerLabel, divider, tableView])
    }
    
    override func setupLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView).inset(8)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(4)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        headerLabel.text = "5일간의 일기예보"
        headerLabel.font = .systemFont(ofSize: 12)
        headerLabel.textColor = .white
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.register(DailyWeatherForecastTableViewCell.self, forCellReuseIdentifier: DailyWeatherForecastTableViewCell.identifier)
    }

}
