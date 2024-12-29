//
//  TallyManager.swift
//  SuperCounterWatch Watch App
//
//  Created by Nonprawich I. on 29/12/2024.
//

import Foundation

@Observable
class TallyManager {
    static let shared = TallyManager()
    
    var tallies: [WatchTally] = []
    var selectedTally: WatchTally?
    
    func updateTallies(tallies: [WatchTally]) {
        self.tallies = tallies
        self.selectedTally = tallies.first
    }
    
    func increaseSelected() {
        if let index = tallies.firstIndex(where: { $0.name == selectedTally?.name }) {
            tallies[index].value += 1
            selectedTally?.value += 1
        }
    }
}
