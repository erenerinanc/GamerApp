//
//  DetailsWorker.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol DetailsWorkingLogic: AnyObject {
    func getGameDetails(request: Details.Case.Request,_ completion: @escaping (Result<GameResponse,Error>) -> Void)
}

final class DetailsWorker: DetailsWorkingLogic {
    func getGameDetails(request: Details.Case.Request, _ completion: @escaping (Result<GameResponse, Error>) -> Void) {
        
    }
}
