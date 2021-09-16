//
//  HomeModels.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

// swiftlint:disable nesting
enum Home {
    
    enum Fetch {
        
        struct Request {
        }
        
        struct Response {
            let gamesList: [GameResponse]
        }
        
        struct ViewModel {
            var gamesList: [Home.Fetch.ViewModel.Game]
            var carouselGames: [Home.Fetch.ViewModel.Game] {
                Array(gamesList[0..<3])
            }
            
            var tableGames: [Home.Fetch.ViewModel.Game] {
                Array(gamesList[3...])
            }
            
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
