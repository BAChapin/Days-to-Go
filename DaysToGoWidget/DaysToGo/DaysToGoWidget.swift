//
//  DaysToGoWidget.swift
//  DaysToGoWidgetExtension
//
//  Created by Brett Chapin on 5/13/24.
//

import WidgetKit
import SwiftUI

struct DaysToGoWidget: Widget {
    private let kind = "Days to Go Widget"
    
    var families: [WidgetFamily] {
        return [.systemSmall, .systemMedium]
    }
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: DaysToGoConfigurationIntent.self, provider: DaysToGoSnapshotTimelineProvider()) { entry in
            DaysToGoWidgetView(entry: entry)
        }
        .supportedFamilies(families)
    }
}
