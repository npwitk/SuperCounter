//
//  SingleTallyView.swift
//  SuperCounterWatch Watch App
//
//  Created by Nonprawich I. on 29/12/2024.
//

import SwiftUI
import WidgetKit

struct SingleTallyView: View {
    @Environment(TallyManager.self) var tallyManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if let selectedTally = tallyManager.selectedTally {
            VStack {
                Text("\(selectedTally.value)")
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(.primary)
                    .contentTransition(.numericText(countsDown: false))
                    .minimumScaleFactor(0.5)
                    .padding()
                    .frame(width: 90 * 1.5, height: 90 * 1.5)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
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
                Text(selectedTally.name)
                    .font(.title3)
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    tallyManager.increaseSelected()
                    let connectivity = watchOSConnectivity.shared
                    connectivity.updateSelectedTally(selectedTally: tallyManager.selectedTally)
                    SharedTally.update(tally: tallyManager.selectedTally)
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
    }
}

//#Preview {
//    @Previewable @State var tallyManager = TallyManager()
//    tallyManager.updateTallies(tallies: WatchTally.mockTAllies)
//    return SingleTallyView()
//        .environment(tallyManager)
//}

#Preview(traits: .mockData) {
    SingleTallyView()
}

struct MockData: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        @Previewable @State var tallyManager = TallyManager()
        tallyManager.updateTallies(tallies: WatchTally.mockTallies)
        return content
            .environment(tallyManager)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mockData: Self = .modifier(MockData())
}
