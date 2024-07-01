//
//  TimeInterval+DateFormat.swift
//  GK
//
//  Created by Branislav Mrganic on 28.6.24..
//

import Foundation

extension TimeInterval {
    
    public enum TimeFormat {
        case dateShort
        case dayMonthHoursMinutes
        case hoursMinutes
        case hours
        case hoursMinutesSeconds
        case minutesSeconds
        
        var value: String {
            switch self {
            case .dateShort:
                return "yyyy-MM-dd"
            case .dayMonthHoursMinutes:
                return "dd.MM.  HH:mm"
            case .hours:
                return "HH"
            case .hoursMinutes:
                return "HH:mm"
            case .hoursMinutesSeconds:
                return "h:mm:ss"
            case .minutesSeconds:
                return "mm:ss"
            }
        }
    }
    
 
    func format(_ format: TimeFormat) -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
        let x = dateFormatter.string(from: date)
        return x
        
    }
}
