//
//  CustomBlockListView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import SwiftUI
import CoreData

struct CustomBlockListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sentinel: Sentinel
    @State private var showAddWebsiteView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases, id: \.self) { category in
                    CategorySectionView(category: category)
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(sentinel)
                }
            }
            .toolbar {
                EditButton()
                    .foregroundColor(.primary)
                Button(action: navigateToAddURLView) {
                    Label("Add URL", systemImage: "plus")
                        .foregroundColor(.primary)
                }
            }
            .sheet(isPresented: $showAddWebsiteView) {
                let viewModel = WebsiteViewModel()
                WebsiteView(viewModel: viewModel)
            }
            .listStyle(.plain)
        }    
    }
    
    private func navigateToAddURLView() {
        showAddWebsiteView.toggle()
    }
}
    
