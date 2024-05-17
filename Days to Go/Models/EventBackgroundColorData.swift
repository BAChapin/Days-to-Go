//
//  EventBackgroundColorData.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/15/24.
//

import SwiftUI
import Foundation

struct EventBackgroundColorData {
    var gradientStart: Color
    var gradientEnd: Color
    var textColor: Color
    
    static func colorData(forTimeInterval timeInterval: TimeInterval) -> EventBackgroundColorData {
        if timeInterval.numberOfYears > 0 {
            return .init(gradientStart: .init(uiColor: .wbYears),
                         gradientEnd: .init(.wbMonths),
                         textColor: .white)
        }
        
        if timeInterval.numberOfDays > 30 {
            return .init(gradientStart: .init(uiColor: .wbMonths),
                         gradientEnd: .init(.wbDays),
                         textColor: .white)
        }
        
        if timeInterval.numberOfDays <= 30 && timeInterval.numberOfDays > 0 {
            return .init(gradientStart: .init(uiColor: .wbDays),
                         gradientEnd: .init(uiColor: .wbHours),
                         textColor: .black)
        }
        
        if timeInterval.numberOfHours < 24 && timeInterval.numberOfHours > 0 {
            return .init(gradientStart: .init(uiColor: .wbHours),
                         gradientEnd: .init(uiColor: .wbMinutes),
                         textColor: .black)
        }
        
        if timeInterval.numberOfHours == 0 {
            return .init(gradientStart: .init(uiColor: .wbMinutes),
                         gradientEnd: .white,
                         textColor: .black)
        }
        
        return .init(gradientStart: .init(uiColor: .wbYears),
                     gradientEnd: .init(.wbMonths),
                     textColor: .black)
    }
}
