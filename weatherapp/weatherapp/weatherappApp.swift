//
//  weatherappApp.swift
//  weatherapp
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI
import CoreData
@main
struct weatherappApp: App {

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LandingView()
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
        }
    }
}

