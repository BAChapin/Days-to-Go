//
//  DaysToGoConfigurationIntent.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/13/24.
//

import WidgetKit
import AppIntents
import SwiftData

struct DaysToGoConfigurationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "DaysToGo"
    static var description: IntentDescription? = .init(stringLiteral: "Watch to see how many days there is before your event.")
    
    @Parameter(title: "Events", default: .auto)
    var events: DaysToGoWidgetContent
    
    @Parameter(title: "Event")
    var specificEvent: EventEntity?
    
    init(events: DaysToGoWidgetContent = .auto, specificEvent: EventEntity? = nil) {
        self.events = events
        self.specificEvent = specificEvent
    }
    
    init() { }
    
    static var parameterSummary: some ParameterSummary {
        When(\.$events, .equalTo, DaysToGoWidgetContent.specific) {
            Summary {
                \.$events
                \.$specificEvent
            }
        } otherwise: {
            Summary {
                \.$events
            }
        }
    }
}

struct EventEntity: AppEntity, Identifiable, Hashable {
    var id: Event.ID
    var name: String
    
    init(id: Event.ID, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from event: Event) {
        self.id = event.id
        self.name = event.name
    }
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Event")
    static var defaultQuery = EventEntityQuery()
}

struct EventEntityQuery: EntityQuery, Sendable {
    func entities(for identifiers: [EventEntity.ID]) async throws -> [EventEntity] {
        let modelContext = ModelContext(try! ModelContainer(for: Event.self))
        let fetchDescriptor = FetchDescriptor<Event>(predicate: #Predicate { identifiers.contains($0.id) })
        let events = try! modelContext.fetch(fetchDescriptor)
        return events.map { EventEntity(from: $0) }
    }
    
    func suggestedEntities() async throws -> [EventEntity] {
        let modelContext = ModelContext(try! ModelContainer(for: Event.self))
        let fetchDescriptor = FetchDescriptor<Event>()
        let events = try! modelContext.fetch(fetchDescriptor)
        return events.map { EventEntity(from: $0) }
    }
}

enum DaysToGoWidgetContent: String, AppEnum {
    case all
    case auto
    case specific
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Event List")
    
    static let caseDisplayRepresentations: [DaysToGoWidgetContent : DisplayRepresentation] = [
        .all: DisplayRepresentation(title: .init("All", comment: "A phrase that means all events should be shown in a widget.")),
        .auto: DisplayRepresentation(title: .init("Auto", comment: "A phrase that means an event will be dynamically displayed in a widget.")),
        .specific: DisplayRepresentation(title: .init("Specific", comment: "A phrase that means only a specific event should be shown in a widget."))
    ]
}
