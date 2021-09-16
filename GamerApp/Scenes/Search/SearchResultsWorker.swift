//
//  SearchResultsWorker.swift
//  GamerApp
//
//  Created by Eren Erinanç on 16.09.2021.
//

import Foundation

protocol SearchResultsWorkingLogic: AnyObject {
    func getSearchedGamesList(request: SearchResults.Fetch.Request,_ completion: @escaping (Result<GamesList,Error>) -> Void)
}

final class SearchResultsWorker: SearchResultsWorkingLogic {
    func getSearchedGamesList(request: SearchResults.Fetch.Request, _ completion: @escaping (Result<GamesList, Error>) -> Void) {
        NetworkManager.shared.fetch(request: APIRequest.searchGames(by: request.searchQuery), model: GamesList.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
