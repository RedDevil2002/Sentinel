//
//  EncouragedAppViewModel.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import FamilyControls
import SwiftUI
import Combine

class EncouragedAppViewModel: ObservableObject {
    var sentinel: Sentinel
    @Published var encouragedApps: FamilyActivitySelection
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        sentinel = Sentinel.shared
        encouragedApps = FamilyActivitySelection(includeEntireCategory: true)
        
        setUpPublishers()
    }
    
    deinit {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func setUpPublishers() {
        $encouragedApps
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { _ in
                self.encourage()
            }
            .store(in: &cancellables)
    }
    
    func encourage() {
        sentinel.encourage(encouragedApps)
    }
}






