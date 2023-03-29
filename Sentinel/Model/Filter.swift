//
//  Switches.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import Foundation

class Filter: ObservableObject {
    
    static let keyName = "Switches"
    static let shared = Filter()
    
    private init() {
        let defaults = UserDefaults.standard
        self.switches = defaults.object(forKey: Filter.keyName) as? [String: Bool] ?? [String: Bool]()
    }
    
    @Published var switches: [String: Bool] = [:] {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(switches, forKey: Filter.keyName)
        }
    }
}

