//
//  TallyQuery+Extension.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 28/12/2024.
//

import Foundation

extension TallyQuery {
    func defaultResult() async -> TallyEntity? {
            try? await suggestedEntities().first
        }
}
