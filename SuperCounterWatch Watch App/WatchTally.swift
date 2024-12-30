//
//  WatchTally.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 29/12/2024.
//

import Foundation

struct WatchTally: Identifiable, Hashable, Codable {
    var name: String
    var value: Int = 0
    var id: String {
       return name
    }
    
    static var mockTallies: [WatchTally] {
        [
            WatchTally(name: "Alpha"),
            WatchTally(name: "Beta", value: 10),
            WatchTally(name: "Gamma", value: 999)
        ]
    }
}
