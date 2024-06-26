//
//  CWMapView.swift
//  CityWeather
//
//  Created by Greed on 6/26/24.
//

import UIKit
import MapKit
import SnapKit

final class CWMapView: BaseView {

    private let backgroundView = CardView()
    private let containerView = UIView()
    private let title = UILabel()
    private let mapView = MKMapView()
    
    override func setHierarchy() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(containerView)
        containerView.addSubviews([title, mapView])
    }
    
    override func setupLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView).inset(8)
        }
        
        title.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(4)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.horizontalEdges.bottom.equalToSuperview().inset(4)
        }
    }
    
    override func setupAttributes() {
        title.text = "강수량"
        title.font = .systemFont(ofSize: 12)
        title.textColor = .white
        mapView.layer.cornerRadius = 4
        mapView.overrideUserInterfaceStyle = .dark
    }

    func setPosition(lat: Double, lon: Double) {
        let marker = MKPointAnnotation()
        marker.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        mapView.addAnnotation(marker)
        let camera = MKMapCamera()
        camera.centerCoordinate = marker.coordinate
        camera.altitude = 1000000.0
        mapView.setCamera(camera, animated: false)
    }
}
