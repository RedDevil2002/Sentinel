//
//  ShieldConfigurationExtension.swift
//  ShieldConfig
//
//  Created by Brian Seo on 2023-03-29.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    let config = ShieldConfiguration(backgroundBlurStyle: .dark,
                                     backgroundColor: .black, icon: UIImage(systemName: "circle.fill"),
                                     title: ShieldConfiguration.Label(text: "Bring your parents", color: .yellow),
                                     subtitle: ShieldConfiguration.Label(text: "Your Sentinel thinks you might be in danger", color: .brown),
                                     primaryButtonLabel: ShieldConfiguration.Label(text: "Password", color: .black),
                                     primaryButtonBackgroundColor: nil,
                                     secondaryButtonLabel: nil)
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        
        config
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        config
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        config
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        config
    }
}
