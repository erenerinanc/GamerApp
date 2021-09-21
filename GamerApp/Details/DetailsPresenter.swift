//
//  DetailsPresenter.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol DetailsPresentationLogic: AnyObject {
    func presentGameDetail(response: Details.Fetch.Response)
}

final class DetailsPresenter: DetailsPresentationLogic {
    
    weak var viewController: DetailsDisplayLogic?
    
    func presentGameDetail(response: Details.Fetch.Response) {
        let game = response.gameDetail
        viewController?.displayGameDetails(for: Details.Fetch.ViewModel(game: Details.Fetch.ViewModel.GameDetail(id: game.id ?? 0, description: game.descriptionRaw ?? "", name: game.name ?? "", imageURL: game.backgroundImage ?? placeHolderImageURL)))
    }
}
