//
//  ContentView.swift
//  SuperCounterWatch Watch App
//
//  Created by Nonprawich I. on 29/12/2024.
//

import SwiftUI

struct TallyUpdateView: View {
    
    let connectivity = watchOSConnectivity.shared
    @Environment(TallyManager.self) var tallyManager
    @State private var changeSelected = false
    
    var body: some View {
        NavigationStack {
            Group {
                if tallyManager.tallies.isEmpty {
                    ContentUnavailableView("Launch the app on the iPhone", systemImage: "iphone.and.arrow.right.inward")
                } else {
                    SingleTallyView()
                }
            }
            .sheet(isPresented: $changeSelected) {
                MyTalliesListView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        changeSelected.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    TallyUpdateView()
}
