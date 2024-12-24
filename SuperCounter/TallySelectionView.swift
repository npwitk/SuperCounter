//
//  ContentView.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 24/12/2024.
//

import SwiftUI
import SwiftData

struct TallySelectionView: View {
    @Query(sort: \Tally.name) var tallies: [Tally]
    @State private var selectedTally: Tally?
    @Environment(\.modelContext) var modelContext
    @State private var newTally = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationStack {
            if tallies.isEmpty {
                ContentUnavailableView {
                    Label("Create your first counter", systemImage: "circle.badge.plus")
                        .font(.title2.weight(.medium))
                } description: {
                    Text("Tap + to get started")
                        .foregroundStyle(.secondary)
                }
            } else {
                VStack(spacing: 32) {
                    Menu {
                        ForEach(tallies) { tally in
                            Button(tally.name) {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedTally = tally
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedTally?.name ?? "Select Counter")
                                .font(.title3.weight(.medium))
                            Spacer()
                            Image(systemName: "chevron.down.circle.fill")
                                .foregroundStyle(.secondary)
                                .imageScale(.large)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal)
                    
                    if let selectedTally {
                        VStack(spacing: 24) {
                            SingleTallyView(size: 100, tally: selectedTally)
                                .padding(.vertical)
                            
                            Button {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedTally.reset()
                                    try? modelContext.save()
                                }
                            } label: {
                                Label("Reset", systemImage: "arrow.counterclockwise")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .navigationTitle("My Counters")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        if !tallies.isEmpty && selectedTally != nil {
                            Button {
                                showDeleteAlert = true
                            } label: {
                                Image(systemName: "trash.circle.fill")
                                    .foregroundStyle(.red)
                                    .font(.title2)
                                    .frame(width: 20)
                            }
                        }
                        Button {
                            newTally = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .frame(width: 20)
                        }
                    }
                }
                .alert("Delete Counter", isPresented: $showDeleteAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        if let selectedTally {
                            withAnimation {
                                modelContext.delete(selectedTally)
                                try? modelContext.save()
                                if !tallies.isEmpty {
                                    self.selectedTally = tallies.first!
                                }
                            }
                        }
                    }
                } message: {
                    Text("Are you sure you want to delete this counter?")
                }
                .sheet(isPresented: $newTally) {
                    NewTallyView(selectedTally: self.$selectedTally)
                        .presentationDetents([.height(250)])
                }
                .onAppear {
                    if !tallies.isEmpty {
                        selectedTally = tallies.first!
                    }
                }
            }
        }
        
    }
}

#Preview("Mock Data", traits: .mockData) {
    TallySelectionView()
}

#Preview("Empty") {
    TallySelectionView()
}
