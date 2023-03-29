//  ActivityMonitor.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-15.
//

import Foundation
import MobileCoreServices
import DeviceActivity
import ManagedSettings

class ActivityMonitor: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
//        let sentinel = Sentinel.shared
//        sentinel.setShieldRestrictions()
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
//        let sentinel = Sentinel.shared
//        sentinel.reset()
    }
}
