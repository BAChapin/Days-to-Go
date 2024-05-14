//
//  DaysToGoProvider.swift
//  DaysToGoWidgetExtension
//
//  Created by Brett Chapin on 5/13/24.
//

import WidgetKit
import SwiftData

struct DaysToGoEntry: TimelineEntry {
    var date: Date
    var snapshot: EventSnapshot?
    
    static var empty: Self {
        Self(date: .now)
    }
}

struct DaysToGoSnapshotTimelineProvider: AppIntentTimelineProvider {
    let modelContext = try! ModelContext(.init(for: Event.self, configurations: .init(isStoredInMemoryOnly: false)))
    
    func events(for configuration: DaysToGoConfigurationIntent) -> [Event] {
        if let id = configuration.specificEvent?.id {
            return try! modelContext.fetch(
                FetchDescriptor<Event>(predicate: #Predicate { $0.id == id })
            )
        } else if configuration.events == .auto {
            var fetchDescription = FetchDescriptor<Event>(sortBy: [.init(\.dateToEvent)])
            fetchDescription.fetchLimit = 1
            return try! modelContext.fetch(
                fetchDescription
            )
        } else {
            return try! modelContext.fetch(
                FetchDescriptor<Event>()
            )
        }
    }
    
    func placeholder(in context: Context) -> DaysToGoEntry {
        let event = try! modelContext.fetch(FetchDescriptor<Event>(sortBy: [.init(\.dateToEvent)])).first!
        return DaysToGoEntry(date: .now, snapshot: .init(event: event, date: .now))
    }
    
    func snapshot(for configuration: DaysToGoConfigurationIntent, in context: Context) async -> DaysToGoEntry {
        let events = events(for: configuration)
        guard let event = events.first else { return .empty }
        
        let snapshot = event.snapshotsForDay().first!
        return DaysToGoEntry(date: .now, snapshot: snapshot)
    }
    
    func timeline(for configuration: DaysToGoConfigurationIntent, in context: Context) async -> Timeline<DaysToGoEntry> {
        let events = events(for: configuration)
        guard let event = events.first else {
            return Timeline(entries: [.empty], policy: .never)
        }
        
        let snapshots = event.snapshotsForDay().map {
            DaysToGoEntry(date: $0.date, snapshot: $0)
        }
        return Timeline(entries: snapshots, policy: .atEnd)
    }
    
    func recommendations() -> [AppIntentRecommendation<DaysToGoConfigurationIntent>] {
        [
            AppIntentRecommendation(intent: DaysToGoConfigurationIntent(events: .all), description: "All Events"),
            AppIntentRecommendation(intent: DaysToGoConfigurationIntent(events: .auto), description: "Closest Event")
        ]
    }
}
