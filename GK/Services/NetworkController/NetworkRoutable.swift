//
//  NetworkRoutable.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import Foundation

protocol NetworkRoutable {
    var endpoint: String { get }
    var jsonData: [String: Any] { get }
}
