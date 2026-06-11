//
//  PapattesApp.swift
//  Papattes
//
//  Created by Kevin MITERMITE on 09/06/2026.
//

import SwiftUI
import SwiftData

@main
struct PapattesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Medication.self,
            Pet.self,
            Reminder.self,
            Vaccine.self,
            VetVisit.self,
            WeightEntry.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
