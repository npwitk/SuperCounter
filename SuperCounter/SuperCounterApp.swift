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
    @State private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            TallySelectionView()
                .onOpenURL { url in
                    guard url.scheme == "mtls",
                          url.host == "tally" else { return }
                    
                    router.tallyName = url.lastPathComponent
                }
        }
        .modelContainer(for: Tally.self)
        .environment(router)
    }
}
