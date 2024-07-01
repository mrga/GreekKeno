//
//  CountdownView+ViewModel.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import SwiftUI
import Combine

extension CountdownView {
    
    @Observable
    class ViewModel {
        
        var timeLeftInSeconds: TimeInterval = 0
        var onZeroCount: (() -> Void)?
        private var timer: AnyCancellable?
        

        
        var date: Date? {
            didSet {
                guard let date = date else {
                    return
                }
                stopTimer()
                timeLeftInSeconds = calculateInitialRemaningTime(from: date)
                startTimer()
            }
        }
        

        
        private func startTimer() {
            timer = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self = self else {
                        return
                    }
                    if (self.timeLeftInSeconds > 0) {
                        self.timeLeftInSeconds -= 1
                    } else {
                        self.stopTimer()
                        self.onZeroCount?()

                    }
                }
        }
        
        private func stopTimer() {
            timer?.cancel()
            timer = nil
        }
        
        
        
        private func calculateInitialRemaningTime(from date: Date) -> TimeInterval {
            let userCalendar = Calendar.current
            let today = Date()
            let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: today)
            let currentDate = userCalendar.date(from: components)!
            
            let dateComponents = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
            
            var eventDateComponents = DateComponents()
            eventDateComponents.year = dateComponents.year
            eventDateComponents.month = dateComponents.month
            eventDateComponents.day = dateComponents.day
            eventDateComponents.hour = dateComponents.hour
            eventDateComponents.minute = dateComponents.minute
            eventDateComponents.second = dateComponents.second
            eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+2")
            
            let eventDate = userCalendar.date(from: eventDateComponents)!
            let timeLeft = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)
            
            let h = (timeLeft.hour ?? 0) * 3600
            let m = (timeLeft.minute ?? 0) * 60
            let s = timeLeft.second ?? 0
            return Double(h + m + s)
        }
    }
    
    
    
}
