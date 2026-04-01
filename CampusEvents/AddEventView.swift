//
//  AddEventView.swift
//  CampusEvents
//
//  Created by Andrew O'Shei on 01/04/2026.
//

import SwiftUI
import Combine

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: EventsViewModel
    
    @State private var title = ""
    @State private var location = ""
    @State private var date = Date()
    @State private var category = EventCategory.academic
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $title)
                    TextField("Location", text: $location)
                    DatePicker("Date", selection: $date)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(EventCategory.allCases, id: \.self) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                }
            }
            .navigationTitle("New Event")
            .toolbar {
                Button("Save") {
                    let newEvent = Event(title: title, date: date, location: location, description: description, category: category)
                    viewModel.events.append(newEvent) // Demonstrates dynamic data update
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddEventView()
}
