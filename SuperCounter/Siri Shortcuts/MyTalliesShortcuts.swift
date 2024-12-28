//
//  MyTalliesShortcuts.swift
//  SuperCounter
//
//  Created by Nonprawich I. on 28/12/2024.
//

import AppIntents

struct MyTalliesShortcuts: AppShortcutsProvider {
    
    static var appShortcuts: [AppShortcut] {
        //        AppShortcut(intent: UpdateTallyIntent(),
        //                    phrases: [
        //                        "Update \(.applicationName)"
        //                    ],
        //                    shortTitle: "Update first tally",
        //                    systemImageName: "1.circle.fill")
        //    }
        
        AppShortcut(intent: UpdateNamedTallyIntent(),
                    phrases: [
                        "Update \(.applicationName)",
                        "Update \(\.$nameEntity) with \(.applicationName)')"
                    ],
                    shortTitle: "Update selected tally",
                    systemImageName: "plus.circle.fill")
    }
}
