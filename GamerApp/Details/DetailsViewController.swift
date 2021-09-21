//
//  DetailsViewController.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import UIKit
import SnapKit
import Nuke

protocol DetailsDisplayLogic: AnyObject {
    func displayGameDetails(for viewModel: Details.Fetch.ViewModel)
}

final class DetailsViewController: UIViewController {
    
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    var viewModel: Details.Fetch.ViewModel?
    var gameId: Int?
    
    var scrollView = UIScrollView()
    var imageView = UIImageView()
    var nameLabel  = UILabel()
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
    
    init(gameId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.gameId = gameId
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
        scrollView.delegate = self
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        guard let gameId = gameId else { return }
        interactor?.fetchGameDetails(request: Details.Fetch.Request(gameId: gameId))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    //MARK: Configure UI
    
    class GradientView: UIView {
        var colors: [CGColor] = [UIColor.black.withAlphaComponent(0.75).cgColor,
                                 UIColor.black.withAlphaComponent(0).cgColor] {
            didSet { gradientLayer.colors = colors }
        }
        
        var startPoint = CGPoint.zero {
            didSet { gradientLayer.startPoint = startPoint }
        }
        
        var endPoint = CGPoint(x: 0, y: 1) {
            didSet { gradientLayer.endPoint = endPoint }
        }
        
        override class var layerClass: AnyClass { CAGradientLayer.self }
        private var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            gradientLayer.colors = colors
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    let shading = GradientView()
    let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    private func layoutUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.directionalEdges.equalToSuperview() }
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        
        descriptionLabel.numberOfLines = 0

        imageView.contentMode = .scaleAspectFill
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.textColor = Colors.primaryLabel
        descriptionLabel.textColor = Colors.secondaryLabel
        scrollView.backgroundColor = Colors.background
        
        view.addSubview(shading)
        view.addSubview(blur)
        blur.isHidden = true
        if #available(iOS 13, *) {
            blur.effect = UIBlurEffect(style: .systemThinMaterialDark)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view)
            make.height.equalTo(300)
        }
        
        shading.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        blur.snp.makeConstraints { make in
            make.edges.equalTo(shading)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view).inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view).inset(8)
            make.bottom.equalToSuperview()
        }
    }
}

extension DetailsViewController: DetailsDisplayLogic {
    func displayGameDetails(for viewModel: Details.Fetch.ViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            Nuke.loadImage(with: viewModel.game.imageURL, into: self.imageView)
            self.descriptionLabel.text = viewModel.game.description
            self.nameLabel.text = viewModel.game.name
        }
    }
}

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageFrame = view.convert(imageView.frame, from: scrollView)
        
        let insetTop = view.safeAreaInsets.top
        let transitionLow = max(insetTop - (imageFrame.maxY - insetTop), 0)
        let transitionHigh = min(insetTop + insetTop, transitionLow)
        let transitionProgress = transitionHigh / insetTop
        
        if transitionProgress == 0 {
            blur.isHidden = true
            shading.isHidden = false
            shading.alpha = 1
        } else if transitionProgress > 0 && transitionProgress < 1 {
            blur.isHidden = false
            shading.isHidden = false
            shading.alpha = 1 - transitionProgress
            blur.alpha = transitionProgress
        } else if transitionProgress == 1 {
            blur.isHidden = false
            blur.alpha = 1
            shading.isHidden = true
        }
    }
}
