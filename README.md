# CampusEvents

**CampusEvents** is a modern iOS application designed to help students discover, manage, and register for events happening around campus. Built using **SwiftUI** and following the **MVVM (Model-View-ViewModel)** design pattern, this project serves as a practical demonstration of core iOS development concepts, including data binding, system framework integration, and responsive UI design.

## 📱 Features

* **Event Discovery**: Browse a curated list of campus events with details such as title, location, and date.
* **Categorization**: Filter events by categories like Academic, Social, Sports, Career, and Technology, each with unique icons and color coding.
* **Favorites System**: Save interesting events to a dedicated "Favorites" tab for quick access.
* **Real-time Search**: Quickly find specific events using the integrated search bar.
* **Add New Events**: A built-in form allows users to dynamically add their own events to the app's local state.
* **Calendar Integration**: Register for events to automatically add them to the iOS Calendar with a pre-configured 30-minute alert (requires user permission).
* **Expiry Validation**: Automatically checks if an event has already passed before allowing registration.

## 🏗 Architecture

The project strictly adheres to the **MVVM** pattern to ensure a clean separation of concerns:

* **Model**: Defines the data structures, such as the `Event` struct and the `EventCategory` enum.
* **View**: Declarative SwiftUI views that react to state changes (e.g., `EventListView`, `EventDetailView`).
* **ViewModel**: The `EventsViewModel` manages the app's business logic, such as filtering events and toggling favorite status, using `@Published` properties to notify the UI of updates.

## 🛠 Tech Stack & Requirements

* **Language**: Swift 5.0+.
* **Framework**: SwiftUI.
* **Database (Future)**: Includes initial support for **SwiftData** for persistent storage.
* **System Integration**: **EventKit** for Calendar and Alert management.
* **IDE**: Xcode 16.2.
* **Platform**: iOS 18.2+.

## 🚀 Getting Started

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/aoshei/campusevents.git
    ```
2.  **Open the project**: Open `CampusEvents.xcodeproj` in Xcode.
3.  **Run the app**: Select an iOS 18.2+ simulator (e.g., iPhone 16) and press `Cmd + R` to build and run.

## 📝 Note for Students

This project was developed by **Andrew O'Shei** as a teaching tool to bridge the gap between general Swift programming and professional iOS app development. It highlights how familiar Android development patterns like MVVM translate directly into the Apple ecosystem.
