//
//  DetailsInteractor.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol DetailsBusinessLogic: AnyObject {
    func fetchGameDetails(request: Details.Fetch.Request)
}

protocol DetailsDataStore: AnyObject {
    var gameDetail: GameDetails? { get set }
}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {

    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkingLogic = DetailsWorker()
    var gameDetail: GameDetails?
    
    func fetchGameDetails(request: Details.Fetch.Request) {
        worker.getGameDetails(request: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.gameDetail = response
                self?.presenter?.presentGameDetail(response: Details.Fetch.Response(gameDetail: response))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }    
}
