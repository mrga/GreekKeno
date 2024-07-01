//
//  PreviouDrawData.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import Foundation

struct PastDraws: Codable {
    private(set) var games: [PastDrawData]
    
    enum CodingKeys: String, CodingKey {
           case games = "content"
       }
}

struct PastDrawData: Codable {
    private(set) var gameId: Int
    private(set) var drawId: Int
    private(set) var drawTime: TimeInterval
    private(set) var winningNumbers: WinningNumbers
}

struct WinningNumbers: Codable {
    let list: [Int]
    let bonus: [Int]
}
