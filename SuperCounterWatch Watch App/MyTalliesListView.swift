//
//  MyTalliesListView.swift
//  SuperCounterWatch Watch App
//
//  Created by Nonprawich I. on 29/12/2024.
//

import SwiftUI

struct MyTalliesListView: View {
    @Environment(TallyManager.self) var tallyManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            ForEach(tallyManager.tallies) { tally in
                Button {
                    withAnimation {
                        tallyManager.selectedTally = tally
                        dismiss()
                    }
                } label: {
                    HStack {
                        Text(tally.name)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Text(tally.value, format: .number)
                            .font(.system(.title2, design: .rounded))
                            .foregroundStyle(.orange)
                            .monospacedDigit()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                }
            }
        }
        .listStyle(.carousel)
    }
}

#Preview(traits: .mockData) {
    MyTalliesListView()
}
