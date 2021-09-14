//
//  DetailsInteractor.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol DetailsBusinessLogic: AnyObject {
    func fetchGameDetails(request: Details.Case.Request)
}

protocol DetailsDataStore: AnyObject {
    var gameDetail: GameResponse? { get set }
}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkingLogic = DetailsWorker()
    var gameDetail: GameResponse?
    
    func fetchGameDetails(request: Details.Case.Request) {
        //2
        
    }
}
