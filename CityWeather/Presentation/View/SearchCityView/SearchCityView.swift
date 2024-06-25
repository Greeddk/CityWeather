//
//  SearchCityView.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit
import SnapKit

final class SearchCityView: BaseView {

    let tableView = UITableView()
    
    override func setHierarchy() {
        self.addSubview(tableView)
    }
    
    override func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(self)
        }
    }
    
    override func setupAttributes() {
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .cwBlue
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorColor = .white
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }

}
