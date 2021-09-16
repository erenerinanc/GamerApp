//
//  SearchResultsInteractor.swift
//  GamerApp
//
//  Created by Eren Erinanç on 16.09.2021.
//

import Foundation

protocol SearchResultsBusinessLogic: AnyObject {
    func fetchSearchedGames(request: SearchResults.Fetch.Request)
}

protocol SearchResultsDataStore: AnyObject {
    var searchedGamesList: [GameResponse] { get set }
}

final class SearchResultsInteractor: SearchResultsBusinessLogic, SearchResultsDataStore {
 
    var presenter: SearchResultsPresentationLogic?
    var worker: SearchResultsWorkingLogic = SearchResultsWorker()
    var searchedGamesList: [GameResponse] = []
    
    func fetchSearchedGames(request: SearchResults.Fetch.Request) {
        worker.getSearchedGamesList(request: request) { result in
            switch result {
            case .success(let response):
                guard let searchedGamesList = response.results else { return }
                self.searchedGamesList = searchedGamesList
                self.presenter?.presentSearchedGames(response: SearchResults.Fetch.Response(searchedGames: searchedGamesList))
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
}
