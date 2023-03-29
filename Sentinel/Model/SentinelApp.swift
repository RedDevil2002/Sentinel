//
//  SentinelApp.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import SwiftUI
import FamilyControls

@main
struct SentinelApp: App {
    let persistenceController = PersistenceController.shared
    let sentinel = Sentinel.shared
    let center = AuthorizationCenter.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
                .environmentObject(sentinel)
                .onAppear {
                    Task {
                        do {
                            try await center.requestAuthorization(for: .individual)
                            sentinel.initiateMonitoringDiscouragedApps()
                            sentinel.initiateMonitoringEncouragedApps()
                        } catch {
                            print("Failed to authorized \(error.localizedDescription)")
                        }
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
        }
    }
}
