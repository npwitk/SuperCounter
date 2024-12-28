//
//  TallyEntity.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 28/12/2024.
//

import AppIntents

struct TallyEntity: AppEntity {
    var id: String
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(name: "Selected Tally")
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    static var defaultQuery = TallyQuery()
}
