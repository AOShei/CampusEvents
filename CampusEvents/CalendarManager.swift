import EventKit

class CalendarManager {
    static let shared = CalendarManager()
    private let eventStore = EKEventStore()

    func addEventToCalendar(title: String, description: String, location: String, date: Date, completion: @escaping (Bool, Error?) -> Void) {
        // Request access to the Calendar
        eventStore.requestFullAccessToEvents { granted, error in
            guard granted && error == nil else {
                completion(false, error)
                return
            }

            let event = EKEvent(eventStore: self.eventStore)
            event.title = title
            event.startDate = date
            event.endDate = date.addingTimeInterval(3600) // 1 hour duration
            event.notes = description
            event.location = location
            event.calendar = self.eventStore.defaultCalendarForNewEvents

            // Add an alert (Alarm) 30 minutes before the event
            let alarm = EKAlarm(relativeOffset: -1800)
            event.addAlarm(alarm)

            do {
                try self.eventStore.save(event, span: .thisEvent)
                completion(true, nil)
            } catch let error {
                completion(false, error)
            }
        }
    }
}
