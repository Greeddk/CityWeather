//
//  CardView.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit

final class CardView: BaseView {

    override func setupAttributes() {
        self.backgroundColor = .black.withAlphaComponent(0.4)
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
    }

}
