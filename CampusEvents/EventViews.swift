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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.events) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        EventRowView(event: event)
                    }
                }
            }
            .navigationTitle("Campus Events")
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
                Button(action: {
                    // Registration action would go here
                }) {
                    Text("Register for Event")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(event.category.color)
                        .cornerRadius(10)
                }
                .padding()
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
