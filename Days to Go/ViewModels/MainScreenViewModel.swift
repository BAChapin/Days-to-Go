//
//  MainScreenViewModel.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import SwiftUI
import SwiftData

extension MainScreen {
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var events: [Event] = []
        var addNewEvent: Bool = false
        var deleteEventAlert: Bool = false
        var eventToDelete: Event?
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        
        private func fetchData() {
            let now = Date()
            do {
                try modelContext.delete(model: Event.self, where: #Predicate<Event> { $0.date <= now })
                let descriptor = FetchDescriptor<Event>(sortBy: [SortDescriptor(\.date)])
                events = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
        
        func add(event: Event) {
            modelContext.insert(event)
            addNewEvent = false
            fetchData()
        }
        
        func deleteEvent() {
            if let eventToDelete {
                modelContext.delete(eventToDelete)
                fetchData()
            }
        }
        
    }
}
