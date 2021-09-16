//
//  SearchResultsViewController.swift
//  GamerApp
//
//  Created by Eren Erinanç on 16.09.2021.
//

import UIKit

protocol SearchResultsDisplayLogic: AnyObject {
    
}

final class SearchResultsViewController: UIViewController {
    
    var interactor: SearchResultsBusinessLogic?
    var router: (SearchResultsRoutingLogic & SearchResultsDataPassing)?
    
    lazy var tableView = UITableView()
    var viewModel: SearchResults.Fetch.ViewModel?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SearchResultsInteractor()
        let presenter = SearchResultsPresenter()
        let router = SearchResultsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.indicatorStyle = .white
        tableView.backgroundColor = Colors.background
        tableView.snp.makeConstraints { $0.directionalMargins.equalToSuperview() }
        tableView.register(TableViewGameCell.self, forCellReuseIdentifier: TableViewGameCell.reuseID)
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text else { return }
        interactor?.fetchSearchedGames(request: SearchResults.Fetch.Request(query: searchQuery))
    }
}

extension SearchResultsViewController: SearchResultsDisplayLogic {
    
}
