//
//  SuperCounterWatch_Complication.swift
//  SuperCounterWatch Complication
//
//  Created by Nonprawich I. on 30/12/2024.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WatchTallyEntry {
        WatchTallyEntry(date: Date(), tally: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (WatchTallyEntry) -> ()) {
        let currentDate = Date.now
        let tally = SharedTally.getTally()
        let entry = WatchTallyEntry(date: currentDate, tally: tally)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        let tally = SharedTally.getTally()
        let entry = WatchTallyEntry(date: currentDate, tally: tally)
        let timelineEntry = Timeline(entries: [entry], policy: .never)
        completion(timelineEntry)
    }

}

struct WatchTallyEntry: TimelineEntry {
    let date: Date
    let tally: WatchTally?
}

struct SuperCounterWatch_ComplicationEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if entry.tally == nil {
            Text("Empty")
        } else {
                   Text("\(entry.tally!.value)")
                       .padding()
                       .background(RoundedRectangle(cornerRadius: 5).stroke(.white, lineWidth: 2))
               }
    }
}

@main
struct SuperCounterWatch_Complication: Widget {
    let kind: String = "SuperCounterWatch_Complication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            
                SuperCounterWatch_ComplicationEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)

        }
        .configurationDisplayName("My Counter")
        .description("Launch SuperCounter from the watch")
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryRectangular) {
    SuperCounterWatch_Complication()
} timeline: {
    WatchTallyEntry(date: .now, tally: nil)
}
