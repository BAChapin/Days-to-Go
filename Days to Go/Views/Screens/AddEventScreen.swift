//
//  AddEventScreen.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import SwiftUI

struct AddEventScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State var eventName: String = ""
    @State var eventDate: Date = Date()
    @State var displayError: String = ""
    var save: (Event) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 25) {
                Text("Event Title:")
                
                TextField(text: $eventName) {
                    Text("Awesome Concert!")
                }
                .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal, 10)
            
            DatePicker("EventDate", selection: $eventDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
                .padding(.horizontal, 10)
            
            Text(displayError)
                .foregroundColor(.red)
                .frame(height: 15)
                .opacity(displayError.isEmpty ? 0 : 1)
                .onChange(of: displayError) { oldValue, newValue in
                    if newValue != oldValue && !newValue.isEmpty {
                        Task {
                            try await Task.sleep(for: .milliseconds(5000))
                            displayError = ""
                        }
                    }
                }
            
            Button {
                validateInput()
            } label: {
                Text("Save Event")
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.top, 25)
    }
    
    private func validateInput() {
        if eventName.isEmpty {
            displayError = "Please enter an event name."
        }
        
        if eventDate < Date() {
            displayError = "Please select a future date."
        }
        
        if displayError.isEmpty {
            save(Event(name: eventName, date: eventDate))
        }
    }
}

#Preview {
    AddEventScreen(save: { event in
        print(event.name)
    })
}
