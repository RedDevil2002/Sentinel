//
//  Model.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import Foundation
import ManagedSettings
import DeviceActivity
import FamilyControls
import UserNotifications

class Sentinel: ObservableObject {
    static let shared = Sentinel()
    let store = ManagedSettingsStore()
    
    private var discouragedApps = FamilyActivitySelection(includeEntireCategory: true)
    private var encouragedApps = FamilyActivitySelection(includeEntireCategory: true)
    
    var start: Date?
    var end: Date?
    
    func getHourAndMin(_ time: Date?) -> (Int, Int)? {
        guard let time = time else { return nil }
        let hour = Calendar.current.component(.hour, from: time)
        let minute = Calendar.current.component(.minute, from: time)
        return (hour, minute)
    }
    
    private init() { }
    
    func request() {
    }
    
    func stopMonitoring() {
        // Create a Device Activity center
        let center = DeviceActivityCenter()
        center.stopMonitoring([.encourage, .always])
    }
    
    func startedEncouragedAppNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Encouraged App Usage"
        content.subtitle = "Kepp up the good work"
        content.sound = UNNotificationSound.default

        // show this notification one second from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    func discourage(_ discouragedApps: FamilyActivitySelection? = nil) {
        if let discouragedApps = discouragedApps {
            self.discouragedApps = discouragedApps
        }
        
        store.shield.applications = self.discouragedApps.applicationTokens
        store.shield.applicationCategories = self.discouragedApps.categoryTokens.isEmpty ? nil: ShieldSettings.ActivityCategoryPolicy.specific(self.discouragedApps.categoryTokens)
        store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(self.discouragedApps.categoryTokens, except: Set())
        store.shield.webDomains = self.discouragedApps.webDomainTokens
    }
    
    func encourage(_ encouragedApps: FamilyActivitySelection? = nil) {
        if let encouragedApps = encouragedApps {
            self.encouragedApps = encouragedApps
        }
        
        let center = DeviceActivityCenter()
        center.stopMonitoring([.encourage])
        initiateMonitoringEncouragedApps()
    }
    
    func initiateMonitoringDiscouragedApps() {
        let (startHour, startMin) = getHourAndMin(start) ?? (0, 0)
        let (endHour, endMin) = getHourAndMin(end) ?? (23, 59)
        
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: startHour, minute: startMin),
            intervalEnd: DateComponents(hour: endHour, minute: endMin),
            repeats: true
        )
        
        let center = DeviceActivityCenter()
        do {
            try center.startMonitoring(.always, during: schedule)
        } catch {
            print(error.localizedDescription)
        }
        
        store.dateAndTime.requireAutomaticDateAndTime = true
        store.account.lockAccounts = true
//        store.passcode.lockPasscode = true
//        store.siri.denySiri = true
//        store.appStore.denyInAppPurchases = true
//        store.appStore.maximumRating = 200
//        store.appStore.requirePasswordForPurchases = true
//        store.media.denyExplicitContent = true
//        store.gameCenter.denyMultiplayerGaming = true
//        store.media.denyMusicService = false
    }
    
    func initiateMonitoringEncouragedApps() {
        print("Setting schedule...")
        print("Hour is: ", Calendar.current.dateComponents([.hour, .minute], from: Date()).hour!)
        print("Minutes is: ", Calendar.current.dateComponents([.hour, .minute], from: Date()).minute!)
        
        // The Device Activity schedule represents the time bounds in which my extension will monitor for activity
        let schedule = DeviceActivitySchedule(
            // I've set my schedule to start and end at midnight
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            // I've also set the schedule to repeat
            repeats: true
        )
        
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] =
        [
            .encourage: DeviceActivityEvent(
                applications: encouragedApps.applicationTokens,
                threshold: DateComponents(minute: 1)
            )
        ]
        
        // Create a Device Activity center
        let center = DeviceActivityCenter()
        do {
            print("Try to start monitoring...")
            // Call startMonitoring with the activity name, schedule, and events
            try center.startMonitoring(.encourage, during: schedule, events: events)
        } catch {
            fatalError("Error monitoring encouraged apps \(error.localizedDescription)")
        }
    }
}

// MARK: DEBUG FUNCTIONS
extension Sentinel {
    
    // Clear store settings
    func reset() {
        store.shield.applications = Set()
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none
        store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.none
        store.shield.webDomains = Set()
        store.clearAllSettings()
    }
    
    func blockAll() {
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.all()
        store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.all()
    }
}

extension DeviceActivityEvent.Name {
    static let encourage = Self("encourage")
}

extension DeviceActivityName {
    static let always = Self("always")
    static let encourage = Self("encourage")
}


//
//
//func unblock() {
//    store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.none
//}
//
//func adultFilterToggled() {
//    if store.webContent.blockedByFilter == .auto() {
//        store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.none
//        let domainsToBLocks = Set(selectionToDiscourage.webDomains).union(customAdultDomainsToBlock)
//        store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.auto(domainsToBLocks)
//    } else {
//        store.webContent.blockedByFilter = .auto()
//    }
//}
//
//
//
//func initiateMonitoringEncouraged() {
//    let schedule = DeviceActivitySchedule(intervalStart: DateComponents(hour: 0, minute: 0), intervalEnd: DateComponents(hour: 23, minute: 59), repeats: true)
//    let center = DeviceActivityCenter()
//    do {
//        try center.startMonitoring(.encouraged, during: schedule)
//    } catch {
//        print(error.localizedDescription)
//    }
//
//    store.dateAndTime.requireAutomaticDateAndTime = true
//    store.account.lockAccounts = true
//}
//
//func initiateMonitoring() {
//}
//
//func addToBlockList(url: String) {
//    let domain = WebDomain(domain: url)
//    customDomainsToBlock.append(domain)
//    guard let token = domain.token else { return }
//    store.shield.webDomains?.insert(token)
//}
//
//func addToAdultBlockList(url: String) {
//    let domain = WebDomain(domain: url)
//    customAdultDomainsToBlock.append(domain)
//    guard let token = domain.token else { return }
//    store.shield.webDomains?.insert(token)
//}
//

//
//func contentRestriction() {
//    store.appStore.denyInAppPurchases = true
//    store.appStore.maximumRating = 300 // Blocks 12+
//    store.appStore.requirePasswordForPurchases = true
//}
//
//func reset() {
//    store.shield.applications = Set()
//    store.shield.webDomains = Set()
//    store.clearAllSettings()
//}

//func setShieldRestrictions(_ discouragedApps: FamilyActivitySelection) {
//    // SET UP DOMAINS
//    discouragedApps
//    let domainsToBLocks = Set(discouragedApps.webDomains).union(customDomainsToBlock)
//    print("model.setShieledRestrictions()\ncustomDomainsToBlock = \(customDomainsToBlock)")
//    print("model.setShieledRestrictions()\ndomainsToBlock = \(domainsToBLocks)")
//
//    print("model.setShieldRestrictions()\nwebDonmains = \(selectionToDiscourage.webDomains)")
//    print("Comparison between \(selectionToDiscourage.webDomains.first.debugDescription) and \(WebDomain(domain: "twitter.com"))")
//    print(selectionToDiscourage.webDomains.first == WebDomain(domain: "twitter.com"))
//
//    store.shield.applications = selectionToDiscourage.applicationTokens
//    store.shield.applicationCategories = selectionToDiscourage.categoryTokens.isEmpty ? nil: ShieldSettings.ActivityCategoryPolicy.specific(selectionToDiscourage.categoryTokens)
//    store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(selectionToDiscourage.categoryTokens, except: Set())
//    store.shield.webDomains = selectionToDiscourage.webDomainTokens.union(Set([WebDomain(domain: "twitter.com")].compactMap({ $0.token
//    })))
//
//    store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.auto(domainsToBLocks)
//
//    store.dateAndTime.requireAutomaticDateAndTime = true
//}
