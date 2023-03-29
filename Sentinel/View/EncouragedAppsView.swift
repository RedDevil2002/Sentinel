//
//  SchedulerView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct EncouragedAppsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sentinel: Sentinel
    
    @ObservedObject var viewModel = EncouragedAppViewModel()
    
    var body: some View {
        FamilyActivityPicker(headerText: "Encouraged Apps", selection: $viewModel.encouragedApps)
    }
}

struct EncouragedAppsView_Previews: PreviewProvider {
    static var previews: some View {
        let sentinel = Sentinel.shared
        EncouragedAppsView()
            .environmentObject(sentinel)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
