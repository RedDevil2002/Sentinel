//
//  WebsiteViewModel.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import SwiftUI

class WebsiteViewModel: ObservableObject {
    let website: Website?
    let persitenceController = PersistenceController.shared
    let destructButton: DestructButton
    
    @Published var domain: String = ""
    @Published var category: Category = .custom
    
    func saveWebsite() {
        persitenceController.saveWebsite(of: domain, in: category.rawValue, to: website)
    }
    
    func deleteWebsite() {
        persitenceController.deleteWebsite(website)
    }
    
    func destructButtonPressed() {
        switch destructButton {
        case let .cancel(action: cancel):
            cancel()
        case let .delete(action: delete):
            delete()
        }
    }
    
    init(website: Website? = nil) {
        self.website = website
        
        if let website = website {
            self.domain = website.domain ?? ""
            self.category = Category(rawValue: website.category ?? Category.custom.rawValue) ?? .custom
            self.destructButton = .delete(action: { PersistenceController.shared.deleteWebsite(website) } )
        } else {
            self.destructButton = .cancel(action: { PersistenceController.shared.deleteWebsite(website) } )
        }
    }
}

extension WebsiteViewModel {
    enum DestructButton {
        typealias Action = () -> ()
        
        case delete(action: Action)
        case cancel(action: Action)
        
        func label() -> Text {
            switch (self) {
            case .delete(action: _):
                return Text("Delete").foregroundColor(.red)
            case .cancel(action: _):
                return Text("Cancel").foregroundColor(.primary)
            }
        }
    }
}
