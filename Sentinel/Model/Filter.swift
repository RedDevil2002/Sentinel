//
//  Switches.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import Foundation
import Combine

class Filter: ObservableObject {
    
    static let keyName = "Switches"
    static let shared = Filter()
    
    private var cancellables: Set<AnyCancellable> = []
    
    private init() {
        let defaults = UserDefaults.standard
        self.switches = defaults.object(forKey: Filter.keyName) as? [String: Bool] ?? [String: Bool]()
        
        setUpSwitchesPublisher()
    }
    
    @Published var switches: [String: Bool] = [:]
    
    deinit {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func setUpSwitchesPublisher() {
        $switches
            .eraseToAnyPublisher()
            .removeDuplicates()
            .sink {
                let defaults = UserDefaults.standard
                defaults.set($0, forKey: Filter.keyName)
            }
            .store(in: &cancellables)
    }
}

