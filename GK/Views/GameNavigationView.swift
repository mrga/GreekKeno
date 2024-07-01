//
//  GameNavigationView.swift
//  GK
//
//  Created by Branislav Mrganic on 28.6.24..
//

import SwiftUI

struct GameNavigationView: View {
    let drawData: DrawData

    var body: some View {
            TabView {
                NavigationView {
                    TalonView(drawData: drawData)
                }
                .tabItem {
                    Label("Talon", systemImage:"square.grid.2x2")
                }
                
                NavigationView {
                    LiveDrawView()
                }
                .tabItem {
                    Label("Live Draw",systemImage:"play.circle")
                }
                
                NavigationView {
                    PastDrawResultsView()
                }
                .tabItem {
                    Label("Results", systemImage: "r.circle")
                }
            }
        }
}
