//
//  CategorySectionView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import SwiftUI
import CoreData

struct CategorySectionView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var sentinel: Sentinel
    
    let category: Category
    private var fetchRequest: FetchRequest<Website>
    private var websites: FetchedResults<Website> {
        fetchRequest.wrappedValue
    }
    
    @ObservedObject var filter = Filter.shared
    
    init(category: Category) {
        self.category = category
        
        fetchRequest = FetchRequest<Website>(entity: Website.entity(), sortDescriptors: [], predicate: NSPredicate(format: "category == %@", category.rawValue))
    }
    
    var body: some View {
        Section {
            if let boolean = binding(for: category.rawValue).wrappedValue, boolean {
                ForEach(websites) { website in
                    let websiteViewModel = WebsiteViewModel(website: website)
                    NavigationLink {
                        WebsiteView(viewModel: websiteViewModel)
                    } label: {
                        Text(website.domain ?? "")
                    }
                }
                .onDelete(perform: delete)
            }
        } header: {
            Toggle(isOn: binding(for: category.rawValue)) {
                Text(category.rawValue.uppercased())
                    .font(.title2)
                    .bold()
            }
//            .toggleStyle(.button)
        }
    }
    
    private func delete(_ offSets: IndexSet) {
        withAnimation {
            offSets.map { websites[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

extension CategorySectionView {
    private func binding(for key: String) -> Binding<Bool> {
        return .init(
            get: { self.filter.switches[key, default: false] },
            set: { self.filter.switches[key] = $0 })
    }
}

struct CategorySectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySectionView(category: .custom)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
