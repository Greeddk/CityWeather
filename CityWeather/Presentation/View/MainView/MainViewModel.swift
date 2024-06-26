//
//  MainViewModel.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ViewModelProtocol {
    
    var disposeBag = DisposeBag()
    let networkManager = NetworkManager()
    
    let selectedCity = BehaviorRelay<City>(value: City(id: 1839726, name: "Asan", country: "KR", coord: Coordinate(lon: 127.004173, lat: 36.783611), timezone: 32400))
    
    struct Input {
        let fetchForecast: PublishRelay<Void>
        let searchBarTapped: Observable<Void>
    }
    
    struct Output {
        let selectedCity: Driver<City>
        let currentWeather: Driver<DailyWeather>
        let hourlyWeather: Driver<[Weather]>
        let dailyWeather: Driver<[DailyWeather]>
        let averageWind: Driver<Double>
        let averageClouds: Driver<Int>
        let averageHumidity: Driver<Int>
        let errorMessage: Driver<String>
        let presentSearchView: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let fetchedWeatherInfo = PublishRelay<[Weather]>()
        
        let currentWeather = PublishRelay<DailyWeather>()
        let hourlyWeather = PublishRelay<[Weather]>()
        let dailyWeather = PublishRelay<[DailyWeather]>()
        
        let averageWind = PublishRelay<Double>()
        let averageClouds = PublishRelay<Int>()
        let averageHumidity = PublishRelay<Int>()
        
        let errorMessage = PublishRelay<String>()
        let presentSearchView = PublishRelay<Void>()
        
        input.fetchForecast
            .debug()
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.networkManager.callRequest(router: CWRouter.forecast5(city: owner.selectedCity.value.name), of: WeatherForecast.self)
                    .catch { error in
                        errorMessage.accept((error as? NetworkError)?.description ?? "알 수 없는 에러입니다.")
                        return Single.just(WeatherForecast(list: [], city: City(id: 0, name: "", country: "", coord: Coordinate(lon: 0, lat: 0), timezone: 0)))
                    }
            }
            .do(onNext: { forecast in
                DateManager.shared.setTimeZone(secondsFromGMT: forecast.city.timezone ?? 32400)
            })
            .map { $0.list.sorted { $0.dt_txt < $1.dt_txt } }
            .bind(to: fetchedWeatherInfo)
            .disposed(by: disposeBag)
        
        fetchedWeatherInfo
            .map {
                $0.filter { DateManager.shared.isToday($0.dt_txt) }
            }
            .map { list in
                list.map { weather -> DailyWeather in
                    let date = DateManager.shared.dateString(from: weather.dt_txt)
                    let maxTemp = list.map { $0.main.temp_max }.max() ?? 0.0
                    let minTemp = list.map { $0.main.temp_min }.min() ?? 0.0
                    let icon = list.compactMap { $0.weather.first?.icon }.max() ?? ""
                    let currentTemp = list[0].main.temp
                    let main = list.compactMap { $0.weather.first?.main }.first ?? ""
                    let description = list.compactMap { $0.weather.first?.description }.first ?? ""
                    
                    return DailyWeather(date: date, maxTemp: maxTemp, minTemp: minTemp, icon: icon, currentTemp: currentTemp, main: main, description: description)
                }
            }
            .bind(with: self) { owner, todayWeather in
                guard let weather = todayWeather.first else { return }
                currentWeather.accept(weather)
            }
            .disposed(by: disposeBag)
        
        fetchedWeatherInfo
            .map {
                $0.filter {
                    return DateManager.shared.isToday($0.dt_txt) || DateManager.shared.isTomorrow($0.dt_txt)
                }
            }
            .bind(to: hourlyWeather)
            .disposed(by: disposeBag)
        
        fetchedWeatherInfo
            .map { weathers in
                let grouped = Dictionary(grouping: weathers) { weather in
                    DateManager.shared.dateString(from: weather.dt_txt)
                }
                let today = Date()
                let dailyWeather = grouped.compactMap { (key, values) -> DailyWeather? in
                    guard let maxTemp = values.map({ $0.main.temp_max }).max(),
                          let minTemp = values.map({ $0.main.temp_min }).min(),
                          let icon = values.compactMap({ $0.weather.first?.icon }).max() else {
                        return nil
                    }
                    
                    guard let weatherDate = DateManager.shared.convertToDate(from: key, format: "yyyy-MM-dd"),
                          weatherDate >= DateManager.shared.startOfDay(for: today) else {
                        return nil
                    }
                    return DailyWeather(date: key, maxTemp: maxTemp, minTemp: minTemp, icon: icon)
                }
                return dailyWeather.sorted { $0.date < $1.date }
            }
            .bind(to: dailyWeather)
            .disposed(by: disposeBag)
        
        fetchedWeatherInfo
            .map { weathers -> (wind: Double, cloud: Int, humidity: Int) in
                let todayWeathers = weathers.filter { DateManager.shared.isToday($0.dt_txt) }
                let totalWindSpeed = todayWeathers.map { $0.wind.speed }.reduce(0, +)
                let totalClouds = todayWeathers.map { $0.clouds.all }.reduce(0, +)
                let totalHumidity = todayWeathers.map { $0.main.humidity }.reduce(0, +)
                let count = Double(todayWeathers.count)
                
                let avgWind = count > 0 ? totalWindSpeed / count : 0
                let avgClouds = count > 0 ? totalClouds / Int(count) : 0
                let avgHumidity = count > 0 ? totalHumidity / Int(count) : 0
                
                return (avgWind, avgClouds, avgHumidity)
            }
            .bind(onNext: { value in
                averageWind.accept(value.wind)
                averageClouds.accept(value.cloud)
                averageHumidity.accept(value.humidity)
            })
            .disposed(by: disposeBag)
        
        input.searchBarTapped
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .bind(to: presentSearchView)
            .disposed(by: disposeBag)
        
        return Output(
            selectedCity: selectedCity.asDriver(onErrorJustReturn: City(id: 1839726, name: "Asan", country: "KR", coord: Coordinate(lon: 127.004173, lat: 36.783611), timezone: 32400)),
            currentWeather: currentWeather.asDriver(onErrorJustReturn: DailyWeather(date: "", maxTemp: 0, minTemp: 0, icon: "", main: nil, description: nil)),
            hourlyWeather: hourlyWeather.asDriver(onErrorJustReturn: []),
            dailyWeather: dailyWeather.asDriver(onErrorJustReturn: []),
            averageWind: averageWind.asDriver(onErrorJustReturn: 0),
            averageClouds: averageClouds.asDriver(onErrorJustReturn: 0),
            averageHumidity: averageHumidity.asDriver(onErrorJustReturn: 0),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: ""),
            presentSearchView: presentSearchView.asDriver(onErrorJustReturn: ())
        )
    }
    
}
