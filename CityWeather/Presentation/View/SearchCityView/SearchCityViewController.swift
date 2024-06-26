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
    private let searchController = UISearchController()
    
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
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        self.navigationItem.searchController = searchController
    }
    
    override func bind() {
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
        
        output.dismissView
            .drive(with: self) { owner, _ in
                owner.searchController.dismiss(animated: true)
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    
    }
    
}
