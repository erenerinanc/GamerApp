//
//  SearchResultsPresenter.swift
//  GamerApp
//
//  Created by Eren Erinanç on 16.09.2021.
//

import Foundation

protocol SearchResultsPresentationLogic: AnyObject {
    func presentSearchedGames(response: SearchResults.Fetch.Response)
}

final class SearchResultsPresenter: SearchResultsPresentationLogic {
    
    weak var viewController: SearchResultsDisplayLogic?
    
    func presentSearchedGames(response: SearchResults.Fetch.Response) {
        let games = response.searchedGames.compactMap {  SearchResults.Fetch.ViewModel.Game(name: $0.name ?? "",
                                                                                            releasedDate: $0.released ?? "",
                                                                                            rating: $0.rating ?? 0.0,
                                                                                            imageURL: $0.backgroundImage ?? placeHolderImageURL)
        }
        viewController?.displaySearchedGames(for: SearchResults.Fetch.ViewModel(searchedGames: games))
    }
}
