//
//  EventCountdownView.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import SwiftUI
import Combine

struct EventCountdownView: View {
    
    @State var countdownValue: String
    var event: Event
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(event: Event, timer: Publishers.Autoconnect<Timer.TimerPublisher>) {
        self.event = event
        self.timer = timer
        _countdownValue = State(initialValue: event.countdownValue)
    }
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text(countdownValue)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .onReceive(timer) { _ in
                        countdownValue = event.countdownValue
                    }
                
                Text("until")
                    .font(.caption)
                    .foregroundStyle(.white)
                
                Text(event.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            
            Spacer()
        }
        .padding(20)
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
