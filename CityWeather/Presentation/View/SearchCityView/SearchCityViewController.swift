//
//  SearchCityViewController.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import UIKit

final class SearchCityViewController: BaseViewController, ViewControllerProtocol {
    
    private let mainView = SearchCityView()
    let viewModel: SearchCityViewModel
    
    init(viewModel: SearchCityViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "도시 검색"
    }
    
    override func bind() {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        self.navigationItem.searchController = searchController
        
        let input = SearchCityViewModel.Input(
            query: searchController.searchBar.rx.text.orEmpty.asObservable(),
            citySelected: mainView.tableView.rx.modelSelected(City.self).asObservable())
        let output = viewModel.transform(input: input)
        
        input.viewDidLoad.accept(())
        
        output.filteredList
            .drive(mainView.tableView.rx.items(
                cellIdentifier: CityTableViewCell.identifier,
                cellType: CityTableViewCell.self)) { row, item, cell in
                    cell.configureCell(item)
                }
                .disposed(by: disposeBag)
        
        mainView.tableView.rx.modelSelected(City.self)
            .bind(with: self) { owner, city in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
