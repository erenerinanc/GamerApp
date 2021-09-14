//
//  HomeRouter.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol HomeRoutingLogic: AnyObject {
    func routeToDetails(index: Int)
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    func routeToDetails(index: Int) {
        let destVC = DetailsViewController()
        destVC.router?.dataStore?.gameDetail = dataStore?.gamesList[index]
    }
}
