//
//  HomePresenter.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol HomePresentationLogic: AnyObject {
    func presentGames(response: Home.Case.Response)
}

final class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    func presentGames(response: Home.Case.Response) {
        //3
        let games = response.gamesList.compactMap { Home.Case.ViewModel.Game(name: $0.name ?? "",
                                                                            releasedDate: $0.released ?? "",
                                                                            rating: $0.rating ?? 0.0,
                                                                            imageURL: $0.backgroundImage ?? ""
            )
        }
        viewController?.displayGamesList(for: Home.Case.ViewModel(gamesList: games))
    }
}
