//
//  ConfigurationAppIntent.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 26/12/2024.
//


import WidgetKit
import AppIntents
import SwiftData

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Selected Tally" }
    static var description: IntentDescription { "Choose your tally from the list." }

    // An example configurable parameter.
    @Parameter(title: "Select Tally", default: nil)
    var selectedTally: TallyEntity?
}


