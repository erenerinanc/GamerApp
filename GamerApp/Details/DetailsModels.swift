//
//  DetailsModels.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

// swiftlint:disable nesting
enum Details {
    
    enum Fetch {
        
        struct Request {
            var gameId: Int
        }
        
        struct Response {
            var gameDetail: GameDetails
        }
        
        struct ViewModel {
            var game: Details.Fetch.ViewModel.GameDetail
            
            struct GameDetail {
                var id: Int
                var description: String
                var name: String
                var imageURL: URL
            }
        }
        
    }
    
}
// swiftlint:enable nesting
