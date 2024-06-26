//
//  NetworkErrorView.swift
//  CityWeather
//
//  Created by Greed on 6/26/24.
//

import UIKit
import SnapKit

final class NetworkErrorView: BaseView {

    let image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wifi.exclamationmark")
        view.tintColor = .red
        return view
    }()
    let label: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.text = "인터넷 연결 상태를 확인해주세요!"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4.withAlphaComponent(0.8)
    }
  
    override func setHierarchy() {
        [image, label].forEach {
            self.addSubview($0)
        }
    }
    
    override func setupLayout() {
        image.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(-50)
            make.centerX.equalTo(self)
            make.size.equalTo(100)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
    }

}
