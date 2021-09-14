//
//  HomeModels.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

// swiftlint:disable nesting
enum Home {
    
    enum Case {
        
        struct Request {
            let path: String
            let params: [String:String]
        }
        
        struct Response {
            let gamesList: [GameResponse]
        }
        
        struct ViewModel {
            var gamesList: [Home.Case.ViewModel.Game]
            
            struct Game {
                var name: String
                var releasedDate: String
                var rating: Double
                var imageURL: String
            }
        }
        
    }
    
}
// swiftlint:enable nesting
