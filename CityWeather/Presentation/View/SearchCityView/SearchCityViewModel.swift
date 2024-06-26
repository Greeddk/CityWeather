//
//  SearchCityViewModel.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchCityViewModel: ViewModelProtocol {
    
    init(cityRepository: CityRepository, selectedCity: BehaviorRelay<City>) {
        self.repository = cityRepository
        self.selectedCity = selectedCity
    }

    var disposeBag = DisposeBag()
    private let repository: CityRepository
    private let selectedCity: BehaviorRelay<City>
    
    struct Input {
        let viewDidLoad = PublishRelay<Void>()
        let query: Observable<String>
        let citySelected: Observable<City>
    }
    
    struct Output {
        let filteredList: Driver<[City]>
        let errorMessage: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let filteredList = BehaviorRelay<[City]>(value: [])
        let errorMessage = PublishRelay<String>()
        
        input.viewDidLoad
            .withUnretained(self)
            .flatMap { owner, _ in
                return owner.repository.getList()
            }
            .bind(to: filteredList)
            .disposed(by: disposeBag)
        
        input.query
            .withUnretained(self)
            .flatMap { owner, query in
                return owner.repository.filterCity(query)
            }
            .bind(to: filteredList)
            .disposed(by: disposeBag)
        
        input.citySelected
            .bind(with: self) { owner, city in
                owner.selectedCity.accept(city)
            }
            .disposed(by: disposeBag)
        
        return Output(
            filteredList: filteredList.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: "")
        )
    }
    
}
