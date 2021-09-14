//
//  DetailsViewController.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import UIKit
import SnapKit

protocol DetailsDisplayLogic: AnyObject {
    func displayGameDetails(for viewModel: Details.Fetch.ViewModel)
}

final class DetailsViewController: UIViewController {
    
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    var viewModel: Details.Fetch.ViewModel?
    
    var imageView = UIImageView()
    var descriptionLabel = UILabel()
    
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
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
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
        
    }
    
    //MARK: Configure UI
    
    private func layoutUI() {
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(300)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }
}

extension DetailsViewController: DetailsDisplayLogic {
    func displayGameDetails(for viewModel: Details.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}
