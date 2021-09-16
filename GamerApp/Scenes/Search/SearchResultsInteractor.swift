//
//  SearchResultsInteractor.swift
//  GamerApp
//
//  Created by Eren Erinanç on 16.09.2021.
//

import Foundation

protocol SearchResultsBusinessLogic: AnyObject {
    func fetchSearchedGames(request: SearchResults.Fetch.Request)
}

protocol SearchResultsDataStore: AnyObject {
    
}

final class SearchResultsInteractor: SearchResultsBusinessLogic, SearchResultsDataStore {
    
    var presenter: SearchResultsPresentationLogic?
    var worker: SearchResultsWorkingLogic = SearchResultsWorker()
    
    func fetchSearchedGames(request: SearchResults.Fetch.Request) {
        
    }
    
}
