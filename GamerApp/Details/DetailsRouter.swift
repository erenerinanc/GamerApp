//
//  DetailsRouter.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import Foundation

protocol DetailsRoutingLogic: AnyObject {
    
}

protocol DetailsDataPassing: AnyObject {
    var dataStore: DetailsDataStore? { get }
}

final class DetailsRouter: DetailsRoutingLogic, DetailsDataPassing {
    
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
    
}
