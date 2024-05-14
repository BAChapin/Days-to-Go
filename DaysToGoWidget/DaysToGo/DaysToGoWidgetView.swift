//
//  DaysToGoWidgetView.swift
//  DaysToGoWidgetExtension
//
//  Created by Brett Chapin on 5/13/24.
//

import SwiftUI
import WidgetKit

struct DaysToGoWidgetView: View {
    var entry: DaysToGoEntry
    
    var body: some View {
        VStack {
            if let snapshot = entry.snapshot {
                Text(snapshot.event.name)
                Text(snapshot.event.countdownValue)
            } else {
                Text("Hello World!")
            }
        }
    }
}
