//
//  Tally.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 24/12/2024.
//

import Foundation
import SwiftData

@Model
class Tally {
    var name: String
    var value: Int
    
    init(name: String, value: Int = 0) {
        self.name = name
        self.value = value
    }
    
    func increase() {
        value += 1
    }
    
    func decrease() {
        if value > 0 {
            value -= 1
        }
    }
    
    func reset() {
        value = 0
    }
    
    static var mockTallies: [Tally] {
        [
            Tally(name: "Alpha"),
            Tally(name: "Beta", value: 10)
        ]
    }
}
