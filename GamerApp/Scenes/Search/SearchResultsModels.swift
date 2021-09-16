//
//  SearchResultsModels.swift
//  GamerApp
//
//  Created by Eren Erinanç on 16.09.2021.
//

import Foundation

// swiftlint:disable nesting
enum SearchResults {
    
    enum Fetch {
        
        struct Request {
            let searchQuery: String
        }
        
        struct Response {
            let searchedGames: [GameResponse]
        }
        
        struct ViewModel {
            let searchedGames: [SearchResults.Fetch.ViewModel.Game]
            
            struct Game {
                var name: String
                var releasedDate: String
                var rating: Double
                var imageURL: URL
            }
        }
        
    }
    
}
// swiftlint:enable nesting
