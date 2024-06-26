//
//  HourlyForecastView.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HourlyForecastView: BaseView {

    private let backgroundView = CardView()
    private let containerView = UIView()
    private let headerLabel = UILabel()
    private let divider = Divider()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 55, height: 80)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func setHierarchy() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(containerView)
        containerView.addSubviews([headerLabel, divider, collectionView])
    }
    
    override func setupLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView).inset(8)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(4)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        headerLabel.text = "3시간 간격 일기예보"
        headerLabel.textColor = .white
        headerLabel.font = .systemFont(ofSize: 12)
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
    }

}
