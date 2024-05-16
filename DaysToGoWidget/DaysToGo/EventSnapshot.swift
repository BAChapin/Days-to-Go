//
//  EventSnapshot.swift
//  DaysToGoWidgetExtension
//
//  Created by Brett Chapin on 5/13/24.
//

import Foundation
import SwiftData

struct EventSnapshot {
    var event: Event
    var date: Date
    var timeOfDay: TimeOfDay
    
    init(event: Event, date: Date) {
        self.event = event
        self.date = date
        self.timeOfDay = .init(date: date)
    }
    
    enum TimeOfDay: String {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case evening = "Evening"
        
        init(date: Date) {
            let components = Calendar.current.dateComponents([.hour], from: date)
            
            switch components.hour! {
            case (4...10): self = .morning
            case (11...16): self = .afternoon
            default: self = .evening
            }
        }
        
        var symbolName: String {
            switch self {
            case .morning: return "sunrise.fill"
            case .afternoon: return "sun.max.fill"
            case .evening: return "sunset.fill"
            }
        }
    }
}

extension Event {
    var widgetCountdownValue: String {
        let remainingTime = dateToEvent.timeIntervalSinceNow
        
        if remainingTime.numberOfYears > 0 {
            return "\(remainingTime.numberOfYears) year\(remainingTime.numberOfYears != 1 ? "s" : ""), \(remainingTime.numberOfDays) day\(remainingTime.numberOfDays != 1 ? "s" : ""), \(remainingTime.numberOfHours) hour\(remainingTime.numberOfHours != 1 ? "s" : "")"
        } else if remainingTime.numberOfDays > 0 {
            return "\(remainingTime.numberOfDays) day\(remainingTime.numberOfDays != 1 ? "s" : ""), \(remainingTime.numberOfHours) hour\(remainingTime.numberOfHours != 1 ? "s" : "")"
        } else if remainingTime.numberOfHours > 0 {
            return "\(remainingTime.numberOfHours) hour\(remainingTime.numberOfHours != 1 ? "s" : ""), \(remainingTime.numberOfMinutes) minute\(remainingTime.numberOfMinutes != 1 ? "s" : "")"
        } else if remainingTime.numberOfMinutes > 0 {
            return "\(remainingTime.numberOfMinutes) minute\(remainingTime.numberOfMinutes != 1 ? "s" : "")"
        }
        
        return "\(remainingTime.numberOfSeconds) second\(remainingTime.numberOfSeconds != 1 ? "s" : "")"
    }
    
    func snapshotsForDay() -> [EventSnapshot] {
        let currentDate = Date()
        var snapshots: [EventSnapshot] = []
        
        snapshots.append(.init(event: self, date: currentDate))
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate)
        guard let year = components.year,
              let month = components.month,
              let day = components.day else {
            return snapshots
        }
        
        // Creates Date objects for 08:00, 14:00, and 20:00 for the current date
        guard let morningDate = DateComponents(calendar: .current, year: year, month: month, day: day, hour: 8, minute: 0).date,
              let afternoonDate = DateComponents(calendar: .current, year: year, month: month, day: day, hour: 14, minute: 0).date,
              let eveningDate = DateComponents(calendar: .current, year: year, month: month, day: day, hour: 20, minute: 0).date else {
            return snapshots
        }
        // Creates a Date object for 08:00 the next day
        let tomorrowMorningDate = morningDate.advanced(by: .secondsInDay)
        
        if morningDate.timeIntervalSince(currentDate) > 0 {
            snapshots.append(.init(event: self, date: morningDate))
        }
        
        if afternoonDate.timeIntervalSince(currentDate) > 0 {
            snapshots.append(.init(event: self, date: afternoonDate))
        }
        
        if eveningDate.timeIntervalSince(currentDate) > 0 {
            snapshots.append(.init(event: self, date: eveningDate))
        }
        
        snapshots.append(.init(event: self, date: tomorrowMorningDate))
        
        return snapshots
    }
}
