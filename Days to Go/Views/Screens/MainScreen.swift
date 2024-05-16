//
//  Main.swift
//  Days to Go
//
//  Created by Brett Chapin on 5/8/24.
//

import SwiftUI
import SwiftData

struct MainScreen: View {
    @State private var viewModel: ViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.events) { event in
                    EventCountdownView(event: event, timer: viewModel.timer)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            viewModel.eventToDelete = event
                            viewModel.deleteEventAlert.toggle()
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Event List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addNewEvent.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.addNewEvent) {
                AddEventScreen(save: viewModel.add)
                    .presentationDetents([.fraction(0.33)])
                    .presentationDragIndicator(.visible)
            }
            .alert("This action cannot be undone!", isPresented: $viewModel.deleteEventAlert) {
                Button("Yes", role: .destructive) {
                    viewModel.deleteEvent()
                }
                
                Button("No", role: .cancel) {
                    viewModel.deleteEventAlert.toggle()
                }
            } message: {
                Text("Are you sure you want to delete this event?")
            }

//            .alert("Are you sure you want to delete this event?", isPresented: <#T##Binding<Bool>#>, actions: <#T##() -> View#>)
        }
    }
}

//#Preview {
//    MainScreen(modelContext: <#ModelContext#>)
//}
