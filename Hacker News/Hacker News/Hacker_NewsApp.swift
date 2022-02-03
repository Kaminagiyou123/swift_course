//
//  Hacker_NewsApp.swift
//  Hacker News
//
//  Created by ran you on 2/2/22.
//

import SwiftUI

@main
struct Hacker_NewsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
