//
//  Endpoint.swift
//  GK
//
//  Created by Branislav Mrganic on 28.6.24..
//

import Foundation

enum Endpoints {
    enum WebAPI {
        private static let baseUrl = "https://api.opap.gr/draws/v3.0"
        public static let liveDraw = "https://www.mozzartbet.com/sr/lotto-animation/26#/"
        public static func upcomingDraws(gameId: Int, upcoming: Int) -> String {
            baseUrl + "/\(gameId)/upcoming/\(upcoming)"
        }
        // dateFormat: yyyy-mm-dd
        public static func pastDraws(gameId: Int, fromDate: String, toDate: String) -> String {
            baseUrl + "/\(gameId)/draw-date/\(fromDate)/\(toDate)"
        }
    }
}
