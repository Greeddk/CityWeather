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
    
    init(cityRepository: CityRepository) {
        self.repository = cityRepository
    }
    
    var disposeBag = DisposeBag()
    private let repository: CityRepository
    private let list = BehaviorRelay<[City]>(value: [])
    
    struct Input {
        let viewDidLoad = PublishRelay<Void>()
        let query: Observable<String>
    }
    
    struct Output {
        let filteredList: Driver<[City]>
        let errorMessage: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let filteredList = BehaviorRelay<[City]>(value: list.value)
        let errorMessage = PublishRelay<String>()
        
        input.viewDidLoad
            .withUnretained(self)
            .flatMap { owner, _ in
                return owner.repository.getList()
            }
            .bind(to: list)
            .disposed(by: disposeBag)
        
        input.query
            .withUnretained(self)
            .flatMap { owner, query in
                return owner.repository.filterCity(query)
            }
            .bind(to: filteredList)
            .disposed(by: disposeBag)
        
        return Output(
            filteredList: filteredList.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage.asDriver(onErrorJustReturn: "")
        )
    }
    
}
