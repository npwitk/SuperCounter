//
//  NewTallyView.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 24/12/2024.
//

import SwiftUI
import SwiftData
import WidgetKit

struct NewTallyView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @Query var tallies: [Tally]
    @Binding var selectedTally: Tally?
    @State private var name: String = ""
    @FocusState private var isNameFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                TextField("Counter Name", text: $name)
                    .textFieldStyle(.plain)
                    .font(.system(.title3, design: .rounded))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
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
                    )
                    .focused($isNameFocused)
                
                Button {
                    let newTally = Tally(name: name)
                    withAnimation {
                        modelContext.insert(newTally)
                        try? modelContext.save()
                        WidgetCenter.shared.reloadAllTimelines()
                        selectedTally = newTally
                        dismiss()
                    }
                } label: {
                    Text("Create Counter")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
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
                        )
                }
                .disabled(name.isEmpty || tallies.map{$0.name}.contains(name))
                .opacity(name.isEmpty || tallies.map{$0.name}.contains(name) ? 0.6 : 1)
                
                Spacer()
            }
            .padding(24)
            .navigationTitle("New Counter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.primary)
                            .opacity(0.6)
                    }
                }
            }
            .onAppear { isNameFocused = true }
        }
    }
}

#Preview {
    NewTallyView(selectedTally: .constant(nil))
}
