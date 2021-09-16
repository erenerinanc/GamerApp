//
//  HomeWorker.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation


protocol HomeWorkingLogic: AnyObject {
    func getGamesLists(_ completion: @escaping ((Result<GamesList, Error>) -> Void))
}

final class HomeWorker: HomeWorkingLogic {
    func getGamesLists(_ completion: @escaping ((Result<GamesList, Error>) -> Void)) {
        //3
        NetworkManager.shared.fetch(request: APIRequest.getGames(), model: GamesList.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
