//
//  GameRow.swift
//  GK
//
//  Created by Branislav Mrganic on 28.6.24..
//

import SwiftUI

struct GameInfoRow: View {
    
    let drawData: DrawData
    let onZeroCount: (() -> Void)?
    @EnvironmentObject var services: Services
    

    var body: some View {
        NavigationLink(destination: GameNavigationView(drawData: drawData).environmentObject(services)) {
            let drawTimeInSeconds = drawData.drawTime / 1000
            HStack {
                Text(drawTimeInSeconds.format(.hoursMinutes))
                    .font(.body)
                Spacer()
                CountdownView(date: Date(timeIntervalSince1970: drawTimeInSeconds)) {
                    onZeroCount?()
                }
            }
        }
    }
    
}

