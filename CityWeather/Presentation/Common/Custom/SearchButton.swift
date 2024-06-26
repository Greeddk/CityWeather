//
//  SearchButton.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit

final class SearchButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .white.withAlphaComponent(0.5)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        self.setTitle("Search", for: .normal)
        self.setTitleColor(.gray, for: .normal)
        self.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        self.tintColor = .gray
        
        self.contentHorizontalAlignment = .left
        
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
    }
}
