//
//  Game.swift
//  GK
//
//  Created by Branislav Mrganic on 28.6.24..
//

import Foundation

struct DrawData: Codable {
    private(set) var gameId: Int
    private(set) var drawId: Int
    private(set) var drawTime: TimeInterval
}

