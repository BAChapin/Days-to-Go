//
//  DateExtension.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import Foundation

extension TimeInterval {
    var secondsInMinutes: Double {
        60
    }
    
    var secondsInHours: Double {
        secondsInMinutes * 60
    }
    
    var secondsInDay: Double {
        secondsInHours * 24
    }
    
    var secondsInYear: Double {
        secondsInDay * 365
    }
    
    var numberOfYears: Int {
        Int(floor(self / secondsInYear))
    }
    
    var numberOfDays: Int {
        Int(floor(self.truncatingRemainder(dividingBy: secondsInYear) / secondsInDay))
    }
    
    var numberOfHours: Int {
        Int(floor(self.truncatingRemainder(dividingBy: secondsInDay) / secondsInHours))
    }
    
    var numberOfMinutes: Int {
        Int(floor(self.truncatingRemainder(dividingBy: secondsInHours) / secondsInMinutes))
    }
    
    var numberOfSeconds: Int {
        Int(self.truncatingRemainder(dividingBy: secondsInMinutes))
    }
}
