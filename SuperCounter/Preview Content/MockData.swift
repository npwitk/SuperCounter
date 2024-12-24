//
//  MockData.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 24/12/2024.
//

import SwiftData
import SwiftUI

struct MockData: PreviewModifier {
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try! ModelContainer(
            for: Tally.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        // Insert objects here
        Tally.mockTallies.forEach { tally in
            container.mainContext.insert(tally)
        }
         
        return container
    }
    
    
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mockData: Self = .modifier(MockData())
}
