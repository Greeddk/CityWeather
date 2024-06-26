//
//  MainViewController.swift
//  CityWeather
//
//  Created by Greed on 6/24/24.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController, ViewControllerProtocol {

    private let mainView = MainView()
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func bind() {
        let input = MainViewModel.Input(
            fetchForecast: PublishRelay<Void>(),
            searchBarTapped: mainView.searchBar.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.selectedCity
            .drive(with: self) { owner, city in
                owner.mainView.setCityLabel(city)
                owner.mainView.mapView.setPosition(lat: city.coord.lat, lon: city.coord.lon)
                owner.mainView.scrollToLeft()
                input.fetchForecast.accept(())
            }
            .disposed(by: disposeBag)
        
        output.currentWeather
            .drive(with: self) { owner, weather in
                owner.mainView.setCurrentWeather(weather)
            }
            .disposed(by: disposeBag)
        
        output.hourlyWeather
            .drive(mainView.hourlyView.collectionView.rx.items(
                cellIdentifier: HourlyForecastCollectionViewCell.identifier,
                cellType: HourlyForecastCollectionViewCell.self)) { item, weather, cell in
                    cell.configureCell(weather)
                }
            .disposed(by: disposeBag)
        
        output.dailyWeather
            .drive(mainView.dailyView.tableView.rx.items(
                cellIdentifier: DailyWeatherForecastTableViewCell.identifier,
                cellType: DailyWeatherForecastTableViewCell.self)) { item, daily, cell in
                    cell.configureCell(daily)
                }
                .disposed(by: disposeBag)
        
        output.presentSearchView
            .drive(with: self) { owner, _ in
                let selectedCity = owner.viewModel.selectedCity
                let searchVM = SearchCityViewModel(cityRepository: CityRepository(), selectedCity: selectedCity)
                let searchVC = SearchCityViewController(viewModel: searchVM)
                owner.navigationController?.pushViewController(searchVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        Driver.combineLatest(output.averageHumidity, output.averageClouds, output.averageWind)
            .drive(with: self) { owner, combined in
                let (humidity, clouds, wind) = combined
                owner.mainView.otherInfoView.setUI(humidity: humidity, cloud: clouds, wind: wind)
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .drive(with: self) { owner, message in
                owner.showAlert(message: message)
            }
            .disposed(by: disposeBag)
        
    }

}

