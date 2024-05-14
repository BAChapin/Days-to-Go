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
}

extension Event {
    func snapshotsForDay() -> [EventSnapshot] {
        // TODO: Make an algorithm to calculate the below
        // Generate snapshots for "now", 0800, 1400, 2000, and 0800 the next day
        
        var snapshots: [EventSnapshot] = []
        // Generate current snapshot
        snapshots.append(.init(event: self, date: .now))
        
        // Generate next time snapshot
        
        
        return snapshots
    }
}
