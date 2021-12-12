//
//  FavoriteEvents.swift
//  DigiTestApp
//
//  Created by Asadullah Jamadar on 11/12/2021.
//

import Foundation

class FavoriteEvents: ObservableObject {
    private var events: Set<String>
    let defaults = UserDefaults.standard
    
    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey: "FavoriteEvents") as? Data {
            let EventData = try? decoder.decode(Set<String>.self, from: data)
            self.events = EventData ?? []
        } else {
            self.events = []
        }
    }
    
    func getEventIds() -> Set<String> {
        return self.events
    }
    
    func isEmpty() -> Bool {
        events.count < 1
    }
    
    func contains(_ event: Event) -> Bool {
        events.contains("\(event.id)")
    }
    
    func add(_ event: Event) {
        objectWillChange.send()
        events.insert("\(event.id)")
        save()
    }
    
    func remove(_ event: Event) {
        objectWillChange.send()
        events.remove("\(event.id)")
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(events)  {
            defaults.set(encoded, forKey: "FavoriteEvents")
        }
    }
}
