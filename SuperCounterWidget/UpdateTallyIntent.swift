//
//  UpdateTallyIntent.swift
//  SuperCounterWidgetExtension
//
//  Created by Nonprawich I. on 26/12/2024.
//

import AppIntents
import SwiftData
import WidgetKit

struct UpdateTallyIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("Update first tally")
    static var description: IntentDescription? = IntentDescription("Tap the tally once to increment")

//    func perform() async throws -> some IntentResult {
//        let update = await updateTally()
//        return .result(value: update)
//    }
    
    func perform() async throws -> some ProvidesDialog {
        let update = await updateTally()
        return .result(dialog: IntentDialog("Update first Tally to \(update)"))
    }
    
    @MainActor func updateTally() -> Int {
        let container = try! ModelContainer(for: Tally.self)
        let sort = [SortDescriptor(\Tally.name)]
        let descriptor = FetchDescriptor<Tally>(sortBy: sort)
        let allTallies = try? container.mainContext.fetch(descriptor)
        
        if let tally = allTallies?.first {
            tally.increase()
            try? container.mainContext.save()
            WidgetCenter.shared.reloadAllTimelines()
            return tally.value
        }
        return 0
    }
}
