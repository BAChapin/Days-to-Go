//
//  MainScreenViewModel.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import SwiftUI
import SwiftData
import Combine

extension MainScreen {
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var events: [Event] = []
        var addNewEvent: Bool = false
        var deleteEventAlert: Bool = false
        var eventToDelete: Event?
        var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
        private var timerAction: AnyCancellable?
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            timerAction = timer.sink { _ in
                if self.events.contains(where: { !$0.isValid }) {
                    self.fetchData()
                }
            }
            fetchData()
        }
        
        private func fetchData() {
            let now = Date()
            do {
                try modelContext.delete(model: Event.self, where: #Predicate<Event> { $0.dateToEvent <= now })
                let descriptor = FetchDescriptor<Event>(sortBy: [SortDescriptor(\.dateToEvent)])
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
