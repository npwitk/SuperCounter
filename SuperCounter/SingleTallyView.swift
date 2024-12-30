//
//  SingleTallyView.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 24/12/2024.
//

import SwiftUI
import SwiftData
import WidgetKit

struct SingleTallyView: View {
    let size: Double
    @Bindable var tally: Tally
    @Environment(\.modelContext) var context
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("\(tally.value)")
            .font(.system(size: size, weight: .bold, design: .rounded))
            .monospacedDigit()
            .foregroundStyle(.primary)
            .contentTransition(.numericText())
            .minimumScaleFactor(0.5)
            .padding()
            .frame(maxWidth: size * 2, maxHeight: size * 2)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(colorScheme == .dark ? .gray.opacity(0.25) : .gray.opacity(0.08))
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: (colorScheme == .dark ? Color.white : .black).opacity(0.4), location: 0.0),
                                    .init(color: (colorScheme == .dark ? Color.white : .black).opacity(0.0), location: 0.4),
                                    .init(color: (colorScheme == .dark ? Color.white : .black).opacity(0.0), location: 0.6),
                                    .init(color: (colorScheme == .dark ? Color.white : .black).opacity(0.1), location: 1.0),
                                ]),
                                startPoint: .init(x: 0.16, y: -0.4),
                                endPoint: .init(x: 0.2, y: 1.5)
                            ),
                            style: .init(lineWidth: 2)
                        )
                }
            )
            
    }
}

#Preview {
    @Previewable @State var tally = Tally(name: "Alpha")
    SingleTallyView(size: 100, tally: tally)
}
