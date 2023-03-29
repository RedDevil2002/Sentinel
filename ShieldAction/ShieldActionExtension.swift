//
//  ShieldActionExtension.swift
//  ShieldAction
//
//  Created by Brian Seo on 2023-03-29.
//

import ManagedSettings

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
    
    let sentinel = Sentinel.shared
    
    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        switch action {
        case .primaryButtonPressed:
            completionHandler(.defer)
            sentinel.request()
        case .secondaryButtonPressed:
            completionHandler(.defer)
            sentinel.request()
        @unknown default:
            fatalError("There were more actions available")
        }
    }
    
    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        // Handle the action as needed.
        switch action {
        case .primaryButtonPressed:
            completionHandler(.defer)
            sentinel.request()
        case .secondaryButtonPressed:
            completionHandler(.defer)
            sentinel.request()
        @unknown default:
            fatalError("There were more actions available")
        }
        
    }
    
    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        // Handle the action as needed.
        switch action {
        case .primaryButtonPressed:
            completionHandler(.defer)
            sentinel.reset()
        case .secondaryButtonPressed:
            completionHandler(.defer)
            sentinel.reset()
        @unknown default:
            fatalError("There were more actions available")
        }
    }
}
