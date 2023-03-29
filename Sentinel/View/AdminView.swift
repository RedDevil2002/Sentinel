//
//  AdminView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import SwiftUI

struct AdminView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sentinel: Sentinel
    @State private var showAddWebsiteView = false
    
    var body: some View {
        Button {
            sentinel.reset()
        } label: {
            Text("Free yourself!!")
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        let sentinel = Sentinel.shared
        AdminView()
            .environmentObject(sentinel)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
