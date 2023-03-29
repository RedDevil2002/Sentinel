//
//  Preference.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import Foundation

class Preference: ObservableObject {
    static let shared = Preference()
    
    @Published var showPreviewOfURL = true
}
