//
//  iOSConnectivity.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 29/12/2024.
//

import Foundation
import WatchConnectivity

class iOSConnectivity: NSObject, WCSessionDelegate {
    static let shared = iOSConnectivity()
    
    override init() { //Activate session
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        Task { @MainActor in
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    print("Watch app installed")
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}
