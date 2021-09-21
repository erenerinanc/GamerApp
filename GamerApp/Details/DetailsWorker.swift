//
//  DetailsWorker.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol DetailsWorkingLogic: AnyObject {
    func getGameDetails(request: Details.Fetch.Request,_ completion: @escaping (Result<GameDetails,Error>) -> Void)
}

final class DetailsWorker: DetailsWorkingLogic {
    func getGameDetails(request: Details.Fetch.Request,_ completion: @escaping (Result<GameDetails, Error>) -> Void) {
        NetworkManager.shared.fetch(request: APIRequest.getGameDetails(gameId: request.gameId), model: GameDetails.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
