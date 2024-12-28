//
//  TallyUpdatedView.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 28/12/2024.
//

import SwiftUI

struct TallyUpdatedView: View {
    let tallyName: String
    let newValue: Int
    
    var body: some View {
        HStack(spacing: 16) {
            
            Text("\(newValue)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(.primary)
                .contentTransition(.numericText())
                .minimumScaleFactor(0.5)
                .padding(24)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray.opacity(0.08))
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .primary.opacity(0.4), location: 0.0),
                                        .init(color: .primary.opacity(0.0), location: 0.4),
                                        .init(color: .primary.opacity(0.0), location: 0.6),
                                        .init(color: .primary.opacity(0.1), location: 1.0),
                                    ]),
                                    startPoint: .init(x: 0.16, y: -0.4),
                                    endPoint: .init(x: 0.2, y: 1.5)
                                ),
                                style: .init(lineWidth: 2)
                            )
                    }
                )
            
            Text("\(tallyName) has been updated")
                .font(.system(size: 24, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
        }
        .padding(16)
        .background(Color(.systemBackground))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TallyUpdatedView(tallyName: "Delta", newValue: 3)
}
