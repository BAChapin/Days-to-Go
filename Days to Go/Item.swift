//
//  Item.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
