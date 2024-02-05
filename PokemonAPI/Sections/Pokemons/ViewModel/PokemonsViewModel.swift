//
//  PokemonsViewModel.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 2/02/24.
//

import Foundation

@Observable class PokemonsViewModel {
    var apiManager: APIManagerProtocol
    var pokemonResponse: PokemonResponse = .init(results: [])
    var text: String = ""
    var showError = false
    var errorMessage: String = ""

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }

    var filteredPokemons: [ResultsResponse] {
        if text.isEmpty {
            return pokemonResponse.results
        } else {
            return pokemonResponse.results.filter { $0.name.contains(text.lowercased()) }
        }
    }

    @MainActor
    func getPokemons() async {
        if !ApiTool.isConnected {
            load()
            return
        }
        if pokemonResponse.results.isEmpty {
            do {
                pokemonResponse = try await apiManager.request(url: "https://pokeapi.co/api/v2/pokemon?limit=50", httpMethod: "GET", request: nil)
            } catch {
                showError = true
                errorMessage = "Ha ocurrido un error, reintenta más tarde"
            }
        }
        save()
    }

    func load() {
        guard let data = UserDefaults.standard.data(forKey: "pokemons"),
              let savedTasks = try? JSONDecoder().decode(PokemonResponse.self, from: data) else {
            pokemonResponse.results = []
            return
        }
        pokemonResponse = savedTasks
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(pokemonResponse)
            UserDefaults.standard.set(data, forKey: "pokemons")
        } catch {
            print(error)
        }
    }
}
