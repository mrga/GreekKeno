//
//  GKApp.swift
//  GK
//
//  Created by Branislav Mrganic on 28.6.24..
//

import SwiftUI

@main
struct GKApp: App {
    let services = Services.shared
    
    var body: some Scene {
        WindowGroup {
            UpcomingDrawsView()
                .environmentObject(services)
                .preferredColorScheme(.dark)
        }
    }
}
