//
//  EventsViewModel.swift
//  CampusEvents
//
//  Created by Andrew O'Shei on 08/04/2025.
//

import SwiftUI
import Combine

class EventsViewModel: ObservableObject {
    @Published var events: [Event] = Event.sampleEvents()
    @Published var favoriteEvents: Set<UUID> = []
    
    // Toggle favorite status
    func toggleFavorite(for event: Event) {
        if favoriteEvents.contains(event.id) {
            favoriteEvents.remove(event.id)
        } else {
            favoriteEvents.insert(event.id)
        }
    }
    
    // Check if event is favorited
    func isFavorite(event: Event) -> Bool {
        return favoriteEvents.contains(event.id)
    }
    
    // Get all favorite events
    func getFavoriteEvents() -> [Event] {
        return events.filter { favoriteEvents.contains($0.id) }
    }
    
    // Filter events by category
    func getEvents(for category: EventCategory?) -> [Event] {
        guard let category = category else {
            return events
        }
        
        return events.filter { $0.category == category }
    }
}
