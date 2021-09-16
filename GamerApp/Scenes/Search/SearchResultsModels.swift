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
            let path: String
            let params: [String:String]
//            let query: String
        }
        
        struct Response {
            let searchedGames: [GameResponse]
        }
        
        struct ViewModel {
            let searchedGames: [SearchResults.Fetch.ViewModel.Games]
            
            struct Games {
                var name: String
                var releasedDate: String
                var rating: Double
                var imageURL: URL
            }
        }
        
    }
    
}
// swiftlint:enable nesting
