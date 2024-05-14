//
//  DateExtension.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import Foundation

extension TimeInterval {
    static var secondsInMinutes: Double {
        60
    }
    
    static var secondsInHours: Double {
        secondsInMinutes * 60
    }
    
    static var secondsInDay: Double {
        secondsInHours * 24
    }
    
    static var secondsInYear: Double {
        secondsInDay * 365
    }
    
    var numberOfYears: Int {
        Int(floor(self / TimeInterval.secondsInYear))
    }
    
    var numberOfDays: Int {
        Int(floor(self.truncatingRemainder(dividingBy: TimeInterval.secondsInYear) / TimeInterval.secondsInDay))
    }
    
    var numberOfHours: Int {
        Int(floor(self.truncatingRemainder(dividingBy: TimeInterval.secondsInDay) / TimeInterval.secondsInHours))
    }
    
    var numberOfMinutes: Int {
        Int(floor(self.truncatingRemainder(dividingBy: TimeInterval.secondsInHours) / TimeInterval.secondsInMinutes))
    }
    
    var numberOfSeconds: Int {
        Int(self.truncatingRemainder(dividingBy: TimeInterval.secondsInMinutes))
    }
}
