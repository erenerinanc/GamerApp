//
//  HomeViewController.swift
//  GamerApp
//
//  Created by Eren ErinanĂ§ on 11.09.2021.
//

import UIKit
import SnapKit

protocol HomeDisplayLogic: AnyObject {
    func displayGamesList(for viewModel: Home.Fetch.ViewModel)
}

final class HomeViewController: UIViewController {
    
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var viewModel: Home.Fetch.ViewModel?
    
    lazy var searchController = UISearchController(searchResultsController: SearchResultsViewController())
    var currentSearchText: String = ""
    fileprivate lazy var tableView = UITableView()
    private lazy var featuredGameCell = FeaturedGameCell()
    
    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor(worker: HomeWorker())
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        tableView.delegate = self
        tableView.dataSource = self
        featuredGameCell.collectionView.dataSource = self
        featuredGameCell.collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureSearchController()
        //1
        interactor?.fetchGameslist()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.sizeToFit()
    }
    
    private func layoutUI() {
        navigationItem.title = "Library"
        view.addSubview(tableView)
        tableView.indicatorStyle = .white
        tableView.backgroundColor = Colors.background
        tableView.snp.makeConstraints { $0.directionalEdges.equalToSuperview() }
        tableView.register(TableViewGameCell.self, forCellReuseIdentifier: TableViewGameCell.reuseID)
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = searchController.searchResultsController as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for games"
        navigationItem.searchController = searchController
    }
}

//MARK: - TableView Delegate & Datasource

extension HomeViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(250 + 16)
        } else {
            return CGFloat(86)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToGameDetails(index: indexPath.item)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel?.tableGames.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return featuredGameCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewGameCell.reuseID, for: indexPath) as? TableViewGameCell else {fatalError("Unable to dequeue reusable cell")}
            guard let model = viewModel?.tableGames[indexPath.row] else {fatalError("Cannot display model")}
            cell.set(for: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel()
        headerLabel.backgroundColor = Colors.background.withAlphaComponent(0.6)
        if section == 0 {
            headerLabel.text = "Featured Games"
        } else {
            headerLabel.text = "Games"
        }
        headerLabel.textColor = .white
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(headerView.layoutMarginsGuide)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        headerView.backgroundColor = Colors.background
        return headerView
    }

}

//MARK: - CollectionView Delegate & DataSource

extension HomeViewController: UICollectionViewDelegateFlowLayout {
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.carouselGames.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseID, for: indexPath) as? CarouselCell else {fatalError("Unable to dequeue reusable cell")}
        guard let model = viewModel?.carouselGames[indexPath.row] else {fatalError("Cannot display model")}
        cell.set(for: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToFeaturedGameDetails(index: indexPath.row)
    }
}

//MARK: - Display Logic

extension HomeViewController: HomeDisplayLogic {
    func displayGamesList(for viewModel: Home.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.featuredGameCell.collectionView.reloadData()
            self.tableView.reloadSections([1], with: .automatic)
        }
    }
}


