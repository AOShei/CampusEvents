//
//  CampusEventsApp.swift
//  CampusEvents
//
//  Created by Andrew O'Shei on 08/04/2025.
//

import SwiftUI
import SwiftData

@main
struct CampusEventsApp: App {
    @StateObject private var viewModel = EventsViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                EventListView()
                    .tabItem {
                        Label("Events", systemImage: "calendar")
                    }
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
                
                CategoriesView()
                    .tabItem {
                        Label("Categories", systemImage: "folder.fill")
                    }
            }
            .environmentObject(viewModel)
        }
    }
}
