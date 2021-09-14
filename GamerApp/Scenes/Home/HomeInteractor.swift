//
//  HomeInteractor.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchGameslist(request: Home.Fetch.Request)
}

protocol HomeDataStore: AnyObject {
    var gamesList: [GameResponse] { get set}
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic
    
    init(worker: HomeWorkingLogic) {
        self.worker = worker
    }

    var gamesList: [GameResponse] = []
    
    func fetchGameslist(request: Home.Fetch.Request) {
        //2
        worker.getGamesLists(request: request) { result in
            switch result {
            case .success(let response):
                guard let gamesList = response.results else { return }
                self.presenter?.presentGames(response: Home.Fetch.Response(gamesList: gamesList))
            case .failure(let error):
                print("Error is:", error)
            }
        }
 
    }
    
    
}
