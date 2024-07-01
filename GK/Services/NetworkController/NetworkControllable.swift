//
//  NetworkControllable.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import Foundation

protocol NetworkControllable {
    func loadUpcamingDrawData(gameId: Int, upcoming: Int, completion: @escaping NetworkCompletion.LoadUpcamingDrawDataCompletion)
    func loadPastDrwas(gameid: Int, from: String, to: String, completion: @escaping NetworkCompletion.LoadPastDrawsCompletion)
}
