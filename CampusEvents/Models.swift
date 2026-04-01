//
//  Models.swift
//  CampusEvents
//
//  Created by Andrew O'Shei on 08/04/2025.
//

import Foundation
import SwiftUI // Needed for 'Color' type

// Event model
struct Event: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var date: Date
    var location: String
    var description: String
    var imageURL: String?
    var category: EventCategory
    
    // Data Generator
    static func sampleEvents() -> [Event] {
        return [
            Event(title: "Mobile App Workshop",
                  date: Date().addingTimeInterval(86400 * 2),
                  location: "Computer Science Building, Room 101",
                  description: "Learn the basics of mobile app development with Swift!",
                  imageURL: "app-workshop",
                  category: .academic),
            
            Event(title: "Campus Hackathon",
                  date: Date().addingTimeInterval(86400 * 7),
                  location: "Student Union, Main Hall",
                  description: "Join us for a 24-hour coding competition!",
                  imageURL: "hackathon",
                  category: .technology),
            
            Event(title: "End of Semester Concert",
                  date: Date().addingTimeInterval(86400 * 14),
                  location: "Campus Green",
                  description: "Celebrate the end of the semester with live music.",
                  imageURL: "concert",
                  category: .social)
        ]
    }
}

// Event categories
enum EventCategory: String, Codable, CaseIterable {
    case academic = "Academic"
    case social = "Social"
    case sports = "Sports"
    case career = "Career"
    case technology = "Technology"
    
    var icon: String {
        switch self {
        case .academic: return "book.fill"
        case .social: return "person.3.fill"
        case .sports: return "sportscourt.fill"
        case .career: return "briefcase.fill"
        case .technology: return "laptopcomputer"
        }
    }
    
    var color: Color {
        switch self {
        case .academic: return .blue
        case .social: return .purple
        case .sports: return .green
        case .career: return .orange
        case .technology: return .red
        }
    }
}
