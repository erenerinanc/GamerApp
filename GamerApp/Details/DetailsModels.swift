//
//  DetailsModels.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

// swiftlint:disable nesting
enum Details {
    
    enum Case {
        
        struct Request {
            var params: [Int:String]
        }
        
        struct Response {
            var gameDetail: GameResponse
        }
        
        struct ViewModel {
            var game: Details.Case.ViewModel.GameDetail
            
            struct GameDetail {
                var id: Int
                var description: String
                var name: String
                var imageURL: String
            }
        }
        
    }
    
}
// swiftlint:enable nesting
