//
//  SentinelApp.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import SwiftUI

@main
struct SentinelApp: App {
    let persistenceController = PersistenceController.shared
    let sentinel = Sentinel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
                .environmentObject(sentinel)
        }
    }
}
