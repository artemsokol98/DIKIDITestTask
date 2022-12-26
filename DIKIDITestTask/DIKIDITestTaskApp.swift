//
//  DIKIDITestTaskApp.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 26.12.2022.
//

import SwiftUI

@main
struct DIKIDITestTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
