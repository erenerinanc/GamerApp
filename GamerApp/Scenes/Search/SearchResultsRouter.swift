//
//  SearchResultsRouter.swift
//  GamerApp
//
//  Created by Eren ErinanĂ§ on 16.09.2021.
//

import Foundation

protocol SearchResultsRoutingLogic: AnyObject {
    
}

protocol SearchResultsDataPassing: AnyObject {
    var dataStore: SearchResultsDataStore? { get }
}

final class SearchResultsRouter: SearchResultsRoutingLogic, SearchResultsDataPassing {
    
    weak var viewController: SearchResultsViewController?
    var dataStore: SearchResultsDataStore?
    
}
