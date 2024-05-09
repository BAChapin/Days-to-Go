//
//  Item.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import Foundation
import SwiftData

@Model
final class Event {
    var name: String
    var date: Date
    
    var countdownValue: String {
        let remainingTime = date.timeIntervalSinceNow
        if remainingTime.numberOfYears > 0 {
            return "\(remainingTime.numberOfYears)y, \(remainingTime.numberOfDays)d, \(remainingTime.numberOfHours)h, \(remainingTime.numberOfMinutes)m, \(remainingTime.numberOfSeconds)s"
        } else if remainingTime.numberOfDays > 0 {
            return "\(remainingTime.numberOfDays)d, \(remainingTime.numberOfHours)h, \(remainingTime.numberOfMinutes)m, \(remainingTime.numberOfSeconds)s"
        } else if remainingTime.numberOfHours > 0 {
            return "\(remainingTime.numberOfHours)h, \(remainingTime.numberOfMinutes)m, \(remainingTime.numberOfSeconds)s"
        } else if remainingTime.numberOfMinutes > 0 {
            return "\(remainingTime.numberOfMinutes) minutes, \(remainingTime.numberOfSeconds) seconds"
        }
        
        return "\(remainingTime.numberOfSeconds) seconds"
    }
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
    }
}
