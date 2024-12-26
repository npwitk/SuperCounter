//
//  Router.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 26/12/2024.
//

import Foundation

@Observable
class Router {
    var tallyName: String?
    init(tallyName: String? = nil) {
        self.tallyName = tallyName
    }
}
