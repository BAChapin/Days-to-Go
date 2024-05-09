//
//  Days_to_GoApp.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import SwiftUI
import SwiftData

@main
struct Days_to_GoApp: App {
    var container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Event.self)
        } catch {
            fatalError("Failed to create ModelContainer for Event.")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainScreen(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
}
