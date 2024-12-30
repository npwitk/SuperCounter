//
//  watchOSConnectivity.swift
//  SuperCounterWatch Watch App
//
//  Created by Nonprawich I. on 29/12/2024.
//

import Foundation
import SwiftUI
import WatchConnectivity
import WidgetKit

class watchOSConnectivity: NSObject, WCSessionDelegate {
    
    static let shared = watchOSConnectivity()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Task { @MainActor in
            let tallyManager = TallyManager.shared
            if let watchTallies = applicationContext["tallies"] as? Data {
                if let decodedTallies = try? JSONDecoder().decode([WatchTally].self, from: watchTallies) {
                    tallyManager.tallies = decodedTallies
                    tallyManager.selectedTally = decodedTallies.first
                    SharedTally.update(tally: tallyManager.selectedTally)
                    WidgetCenter.shared.reloadAllTimelines()
                } else {
                    print("Failed to decode tallies JSON")
                }
            } else {
                if let updatedTally = applicationContext["update"] as? Data {
                    if let decodedUpdate = try? JSONDecoder().decode(WatchTally.self, from: updatedTally) {
                        if let index = tallyManager.tallies.firstIndex(where: { $0.name == decodedUpdate.name }) {
                            tallyManager.tallies[index].value = decodedUpdate.value
                            if tallyManager.selectedTally?.name == decodedUpdate.name {
                                withAnimation {
                                    tallyManager.selectedTally?.value = decodedUpdate.value
                                    SharedTally.update(tally: tallyManager.selectedTally)
                                    WidgetCenter.shared.reloadAllTimelines()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setContext(to payload: [String : Any]) {
           let session = WCSession.default
           if session.activationState == .activated {
               do {
                   try session.updateApplicationContext(payload)
               } catch {
                   print("Updating context failed")
               }
           }
       }
    
    func updateSelectedTally(selectedTally: WatchTally?) {
            if let selectedTally {
                if let jsonData = try? JSONEncoder().encode(selectedTally) {
                    let updatePayload: [String : Any] = ["update" : jsonData]
                    setContext(to: updatePayload)
                }
            }
        }
    
}
