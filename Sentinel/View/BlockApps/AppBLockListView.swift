//
//  SchedulerView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct AppBLockListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sentinel: Sentinel
    @State private var showAddWebsiteView = false
    
    @ObservedObject var viewModel = AppViewModel()
    
    var body: some View {
        FamilyActivityPicker(selection: $viewModel.discouragedApps)
    }
}

struct AppBLockListView_Previews: PreviewProvider {
    static var previews: some View {
        let sentinel = Sentinel.shared
        AppBLockListView()
            .environmentObject(sentinel)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
