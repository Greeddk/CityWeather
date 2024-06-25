//
//  SearchCityViewController.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit

final class SearchCityViewController: BaseViewController, ViewControllerProtocol {
    
    let mainView = SearchCityView()
    let viewModel: SearchCityViewModel
    
    init(viewModel: SearchCityViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func bind() {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "도시 검색"
        
        let input = SearchCityViewModel.Input(query: searchController.searchBar.rx.text.orEmpty.asObservable())
        let output = viewModel.transform(input: input)
        
        input.viewDidLoad.accept(())
        
        output.filteredList
            .drive(mainView.tableView.rx.items(
                cellIdentifier: CityTableViewCell.identifier,
                cellType: CityTableViewCell.self)) { row, item, cell in
                    cell.configureCell(item)
                }
                .disposed(by: disposeBag)
    }
    
}
