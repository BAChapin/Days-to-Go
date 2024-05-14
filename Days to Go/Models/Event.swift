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
    typealias ID = String
    @Attribute(.unique) public var id: String = UUID().uuidString
    var name: String
    var dateCreated: Date = Date()
    var dateToEvent: Date
    
    var countdownValue: String {
        let remainingTime = dateToEvent.timeIntervalSinceNow
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
        self.dateToEvent = date
    }
}
