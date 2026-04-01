//
//  SupportingViews.swift
//  CampusEvents
//
//  Created by Andrew O'Shei on 08/04/2025.
//

import SwiftUI

// Favorites View
struct FavoritesView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.getFavoriteEvents().isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "star.slash")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No Favorites Yet")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Events you mark as favorites will appear here.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else {
                    List {
                        ForEach(viewModel.getFavoriteEvents()) { event in
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EventRowView(event: event)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

// Categories View
struct CategoriesView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: FilteredEventsView(category: nil)) {
                    Label("All Events", systemImage: "calendar")
                        .font(.headline)
                }
                
                Section(header: Text("Categories")) {
                    ForEach(EventCategory.allCases, id: \.self) { category in
                        NavigationLink(destination: FilteredEventsView(category: category)) {
                            Label {
                                Text(category.rawValue)
                            } icon: {
                                Image(systemName: category.icon)
                                    .foregroundColor(category.color)
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Event Categories")
        }
    }
}

// Filtered Events View
struct FilteredEventsView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    let category: EventCategory?
    
    var body: some View {
        let events = viewModel.getEvents(for: category)
        
        List {
            if events.isEmpty {
                Text("No events in this category")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                ForEach(events) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        EventRowView(event: event)
                    }
                }
            }
        }
        .navigationTitle(category?.rawValue ?? "All Events")
    }
}
