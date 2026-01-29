//
//  PersistenceController.swift
//  weatherapp
//
//  Created by rentamac on 1/27/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "WeatherModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data load failed: \(error)")
            }
        }
    }
}
