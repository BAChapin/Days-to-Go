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
                DaysToGoSnapshotView(snapshot: snapshot)
            } else {
                Text("Hello World!")
            }
        }
    }
}

struct DaysToGoSnapshotView: View {
    
    let snapshot: EventSnapshot
    let colorData: EventBackgroundColorData
    
    init(snapshot: EventSnapshot) {
        self.snapshot = snapshot
        self.colorData = .colorData(forTimeInterval: snapshot.event.dateToEvent.timeIntervalSinceNow)
    }
    
    var body: some View {
        VStack {
            header
            
            Spacer()
            
            Text(snapshot.event.widgetCountdownValue)
                .font(.title2)
                .foregroundStyle(colorData.textColor)
            
            Spacer()
        }
        .containerBackground(for: .widget) {
            WidgetBackgroundView(colorData: colorData)
        }
    }
    
    @ViewBuilder
    var header: some View {
        HStack {
            Text(snapshot.event.name)
                .font(.callout)
                .foregroundStyle(colorData.textColor)
            
            Spacer()
            
            Image(systemName: snapshot.timeOfDay.symbolName)
                .foregroundColor(colorData.textColor)
        }
    }
}

struct WidgetBackgroundView: View {
    var colorData: EventBackgroundColorData
    
    init(colorData: EventBackgroundColorData) {
        self.colorData = colorData
    }
    
    var body: some View {
        LinearGradient(
            colors: [
                colorData.gradientStart,
                colorData.gradientEnd
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}
