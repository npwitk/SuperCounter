//
//  SuperCounterWatchApp.swift
//  SuperCounterWatch Watch App
//
//  Created by Nonprawich I. on 29/12/2024.
//

import SwiftUI

@main
struct SuperCounterWatch_Watch_AppApp: App {
    
    @State private var tallyManager = TallyManager.shared
    
    var body: some Scene {
        WindowGroup {
            TallyUpdateView()
                .environment(tallyManager)
        }
    }
}
