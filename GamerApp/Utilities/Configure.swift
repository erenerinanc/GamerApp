//
//  Configure.swift
//  GamerApp
//
//  Created by Eren ErinanĂ§ on 14.09.2021.
//

import Foundation

protocol Configurable: AnyObject {}

extension Configurable {
    func configure(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Configurable { }
