//
//  PokemonApiApp.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 2/02/24.
//

import SwiftUI
import SwiftData

@main
struct PokemonApiApp: App {
    /* var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PokemonResponse.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()*/

    var body: some Scene {
        WindowGroup {
            PokemonsFactory.getPokemonsView()
        }
        .modelContainer(for: [ResultsResponse.self])
    }
}
