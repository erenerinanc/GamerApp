//
//  HomeRouter.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol HomeRoutingLogic: AnyObject {
    func routeToFeaturedGameDetails(index: Int)
    func routeToGameDetails(index: Int)
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    func routeToFeaturedGameDetails(index: Int) {
        guard let gameId = dataStore?.gamesList[0..<3][index].id else { return }
        let destVC = DetailsViewController(gameId: gameId)
        self.viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func routeToGameDetails(index: Int) {
        guard let gameId = dataStore?.gamesList[3...][index+3].id else { return }
        let destVC = DetailsViewController(gameId: gameId)
        self.viewController?.navigationController?.pushViewController(destVC, animated: true)

    }
}
