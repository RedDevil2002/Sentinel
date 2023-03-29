//
//  SchedulerViewModel.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import FamilyControls
import SwiftUI
import Combine

class DiscouragedAppViewModel: ObservableObject {
    var sentinel: Sentinel
    @Published var discouragedApps: FamilyActivitySelection
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        sentinel = Sentinel.shared
        discouragedApps = FamilyActivitySelection(includeEntireCategory: true)
        
        setUpPublishers()
    }
    
    deinit {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func setUpPublishers() {
        $discouragedApps
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { _ in
                self.discourage()
            }
            .store(in: &cancellables)
        
        
    }
    
    func discourage() {
        sentinel.discourage(discouragedApps)
    }
    
}
