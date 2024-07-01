//
//  Services.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import Foundation

class Services : ObservableObject{
    static let shared = Services()
    let webApi = NetworkController()
    private init() {
         
     }
}
