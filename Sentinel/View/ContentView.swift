//
//  ContentView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var sentinel: Sentinel
    
    var body: some View {
        TabView {
            WebDomainBlockListView()
                .environmentObject(sentinel)
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            DiscouragedAppsView()
                .environmentObject(sentinel)
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Image(systemName: "hand.raised.app.fill")
                }
            
            EncouragedAppsView()
                .environmentObject(sentinel)
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Image(systemName: "app.badge.checkmark.fill")
                }
            
            SchedulerView()
                .environmentObject(sentinel)
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Image(systemName: "timer.circle.fill")
                }
            
            AdminView()
                .environmentObject(sentinel)
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Image(systemName: "key.fill")
                }
        }
        .tint(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let sentinel = Sentinel.shared
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(sentinel)
        
        
    }
}
