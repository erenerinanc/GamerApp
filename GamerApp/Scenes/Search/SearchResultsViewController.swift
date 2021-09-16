//
//  SearchResultsViewController.swift
//  GamerApp
//
//  Created by Eren Erinanç on 16.09.2021.
//

import UIKit

protocol SearchResultsDisplayLogic: AnyObject {
    func displaySearchedGames(for viewModel: SearchResults.Fetch.ViewModel)
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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.indicatorStyle = .white
        tableView.backgroundColor = Colors.background
        tableView.snp.makeConstraints { $0.directionalMargins.equalToSuperview() }
        tableView.register(TableViewGameCell.self, forCellReuseIdentifier: TableViewGameCell.reuseID)
    }
}

extension SearchResultsViewController: UITableViewDelegate {
    
}

extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searchedGames.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewGameCell.reuseID) as? TableViewGameCell else {fatalError("Unable to dequeue reusable cell")}
        guard let model = viewModel?.searchedGames[indexPath.row] else {fatalError("Unable to display model")}
        cell.set(for: Home.Fetch.ViewModel.Game(name: model.name,
                                                releasedDate: model.releasedDate,
                                                rating: model.rating,
                                                imageURL: model.imageURL))
        return cell
    }
    
    
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text else { return }
        interactor?.fetchSearchedGames(request: SearchResults.Fetch.Request(searchQuery: searchQuery))
    }
}

extension SearchResultsViewController: SearchResultsDisplayLogic {
    func displaySearchedGames(for viewModel: SearchResults.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
