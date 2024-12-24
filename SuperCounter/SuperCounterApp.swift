//
//  SuperCounterApp.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 24/12/2024.
//

import SwiftUI
import SwiftData

@main
struct SuperCounterApp: App {
    var body: some Scene {
        WindowGroup {
            TallySelectionView()
        }
        .modelContainer(for: Tally.self)
    }
}
