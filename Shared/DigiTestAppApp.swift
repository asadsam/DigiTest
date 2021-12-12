//
//  DigiTestAppApp.swift
//  Shared
//
//  Created by Asadullah Jamadar on 10/12/2021.
//

import SwiftUI

@main
struct DigiTestAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EventsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
