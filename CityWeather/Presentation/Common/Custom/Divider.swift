//
//  Divider.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit
import SnapKit

final class Divider: BaseView {

    override func setupLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
    
    override func setupAttributes() {
        self.backgroundColor = .lightGray
    }

}
