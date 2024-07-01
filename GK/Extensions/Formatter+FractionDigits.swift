//
//  Formatter+FractionDigits.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import Foundation

extension Formatter {
    static let custom: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

extension FloatingPoint {
    var isWholeNumber: Bool { isNormal ? self == rounded() : isZero }
    var maximum2: String {
        Formatter.custom.minimumFractionDigits = isWholeNumber ? 0 : 2
        return Formatter.custom.string(for: self) ?? ""
    }
}
