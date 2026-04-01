//
//  ContentView.swift
//  CampusEvents
//
//  Created by Andrew O'Shei on 08/04/2025.
//

import SwiftUI

// Event List View
struct EventListView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    @State private var searchText = ""
    @State private var isShowingAddEvent: Bool = false
    
    // Filtering logic
    var filteredEvents: [Event] {
        if searchText.isEmpty {
            return viewModel.events
        } else {
            return viewModel.events.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredEvents) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        EventRowView(event: event)
                    }
                }
            }
            // Add title
            .navigationTitle("Campus Events")
            // Add search bar
            .searchable(text: $searchText, prompt: "Search events")
            // Add toolbar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingAddEvent = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddEvent) {
                AddEventView()
            }
        }
    }
}

// Event Row View
struct EventRowView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    let event: Event
    
    var body: some View {
        HStack {
            Image(systemName: event.category.icon)
                .font(.system(size: 30))
                .foregroundColor(event.category.color)
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                
                Text(event.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(formattedDate(event.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.toggleFavorite(for: event)
            }) {
                Image(systemName: viewModel.isFavorite(event: event) ? "star.fill" : "star")
                    .foregroundColor(viewModel.isFavorite(event: event) ? .yellow : .gray)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// Event Detail View
struct EventDetailView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    @State private var showingExpiredAlert = false
    @State private var showingSuccessAlert = false
    @State private var alertMessage = ""
    let event: Event
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header with category and favorite button
                HStack {
                    Label(event.category.rawValue, systemImage: event.category.icon)
                        .font(.subheadline)
                        .foregroundColor(event.category.color)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(event.category.color.opacity(0.1))
                        )
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleFavorite(for: event)
                    }) {
                        Image(systemName: viewModel.isFavorite(event: event) ? "star.fill" : "star")
                            .font(.title2)
                            .foregroundColor(viewModel.isFavorite(event: event) ? .yellow : .gray)
                    }
                }
                .padding(.horizontal)
                
                // Mock image
                ZStack {
                    Rectangle()
                        .fill(event.category.color.opacity(0.2))
                        .aspectRatio(16/9, contentMode: .fit)
                    
                    Image(systemName: event.category.icon)
                        .font(.system(size: 60))
                        .foregroundColor(event.category.color)
                }
                
                // Event details
                VStack(alignment: .leading, spacing: 12) {
                    Text(event.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Label(formattedDate(event.date), systemImage: "calendar")
                            .font(.subheadline)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Label(event.location, systemImage: "location.fill")
                            .font(.subheadline)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    Text("About this event")
                        .font(.headline)
                    
                    Text(event.description)
                        .font(.body)
                        .lineSpacing(4)
                }
                .padding(.horizontal)
                
                // Registration button (demo only)
		// Inside EventDetailView in EventViews.swift
		Button(action: {
		    // 1. Check if the event has already happened
		    if event.date < Date() {
			alertMessage = "This event has already expired and cannot be registered for."
			showingExpiredAlert = true
		    } else {
			// 2. If not expired, try to add to calendar
			CalendarManager.shared.addEventToCalendar(
			    title: event.title,
			    description: event.description,
			    location: event.location,
			    date: event.date
			) { success, error in
			    DispatchQueue.main.sync {
				if success {
				    alertMessage = "Successfully added to your calendar with a 30-minute alert!"
				    showingSuccessAlert = true
				} else {
				    alertMessage = "Could not add to calendar. Please check permissions."
				    showingExpiredAlert = true
				}
			    }
			}
		    }
		}) {
		    Text("Register for Event")
			.fontWeight(.semibold)
			.foregroundColor(.white)
			.frame(maxWidth: .infinity)
			.padding()
			.background(event.date < Date() ? Color.gray : event.category.color) // Change color if expired
			.cornerRadius(10)
		}
		// 3. Add the popups (Alerts)
		.alert("Event Status", isPresented: $showingExpiredAlert) {
		    Button("OK", role: .cancel) { }
		} message: {
		    Text(alertMessage)
		}
		.alert("Success!", isPresented: $showingSuccessAlert) {
		    Button("Great!", role: .cancel) { }
		} message: {
		    Text(alertMessage)
		}.padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
