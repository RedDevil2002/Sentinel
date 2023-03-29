//
//  DiscouragedAppsView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct DiscouragedAppsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sentinel: Sentinel
    
    @ObservedObject var viewModel = DiscouragedAppViewModel()
    
    var body: some View {
        FamilyActivityPicker(headerText: "Discouraged Apps", selection: $viewModel.discouragedApps)
    }
}



struct DiscouragedAppsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscouragedAppsView()
    }
}
