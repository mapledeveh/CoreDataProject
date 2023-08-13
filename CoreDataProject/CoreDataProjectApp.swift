//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Alex Nguyen on 2023-07-01.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
