//
//  NetworkCompletion.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import Foundation

enum NetworkCompletion {
    typealias LoadUpcamingDrawDataCompletion = (_ result: Result<[DrawData], Error>) -> Void
    typealias LoadPastDrawsCompletion = (_ result: Result<PastDraws, Error>) -> Void
}
