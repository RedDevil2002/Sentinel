//
//  SchedulerView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import SwiftUI

struct SchedulerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sentinel: Sentinel
    @State private var showAddWebsiteView = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SchedulerView_Previews: PreviewProvider {
    static var previews: some View {
        let sentinel = Sentinel.shared
        SchedulerView()
            .environmentObject(sentinel)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
