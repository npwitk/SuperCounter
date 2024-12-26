//
//  SuperCounterWidget.swift
//  SuperCounterWidget
//
//  Created by Nonprawich I. on 25/12/2024.
//

import WidgetKit
import SwiftData
import SwiftUI

struct Provider: TimelineProvider {
    
    var container: ModelContainer = {
        try! ModelContainer(for: Tally.self)
    }()
    
    func placeholder(in context: Context) -> FirstTallyEntry {
        FirstTallyEntry(date: Date(), tallies: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (FirstTallyEntry) -> ()) {
        let currentDate = Date.now
        Task {
            let allTallies = try await getTaillies()
            let entry = FirstTallyEntry(date: currentDate, tallies: allTallies)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        Task {
            let allTallies = try await getTaillies()
            let entry = FirstTallyEntry(date: currentDate, tallies: allTallies)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    
    @MainActor func getTaillies() throws -> [Tally] {
        let sort = [SortDescriptor(\Tally.name)]
        let descriptor = FetchDescriptor<Tally>(sortBy: sort)
        let allTallies = try? container.mainContext.fetch(descriptor)
        
        return allTallies ?? []
    }

}

struct FirstTallyEntry: TimelineEntry {
    let date: Date
    let tallies: [Tally]
}

struct FirstTallyEntryWidget : View {
    var entry: Provider.Entry

    var body: some View {
        if entry.tallies.isEmpty {
            ContentUnavailableView("No Tallies Yet", systemImage: "plus.circle.fill")
        } else {
            VStack {
                Button(intent: UpdateTallyIntent()) {
                    SingleTallyView(size: 50, tally: entry.tallies.first!)
                }
                .buttonStyle(.plain)
                Text(entry.tallies.first!.name)
                    .font(.caption)
                    .fontDesign(.rounded)
                    .bold()
            }
        }
    }
}

struct FirstTallyWidget: Widget {
    let kind: String = "FirstTallyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
                FirstTallyEntryWidget(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("First Tally")
        .description("This value of the first tally")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    FirstTallyWidget()
} timeline: {
    FirstTallyEntry(date: .now, tallies: [])
}
