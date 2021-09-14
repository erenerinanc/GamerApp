//
//  HomeViewController.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import UIKit
import SnapKit

protocol HomeDisplayLogic: AnyObject {
    func displayGamesList(for viewModel: Home.Case.ViewModel)
}

final class HomeViewController: UIViewController {
    
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var viewModel: Home.Case.ViewModel?
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
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
        let interactor = HomeInteractor(worker: HomeWorker())
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        //1
        interactor?.fetchGameslist(request: Home.Case.Request(path: APIRequest.getGames().path, params: APIRequest.getGames().parameters))
        
    }
    
    private func layoutUI() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseId)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.8, height: collectionView.frame.height/1.5)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.gamesList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseId, for: indexPath) as? GameCell else { fatalError("Unable to dequeue reusable cell")}
        guard let model = viewModel?.gamesList[indexPath.row] else { fatalError("Cannot display model") }
        cell.set(for: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToDetails(index: indexPath.item)
    }

}

extension HomeViewController: HomeDisplayLogic {
    func displayGamesList(for viewModel: Home.Case.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
