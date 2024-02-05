//
//  PokemonDetailViewModel.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import Foundation

@Observable class PokemonDetailViewModel {
    var apiManager: APIManagerProtocol
    var pokemon: ResultsResponse
    var pokemonDetail: PokemonDetail = .init(types: [], abilities: [], moves: [])
    var isLoading = false

    init(pokemon: ResultsResponse, apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
        self.pokemon = pokemon
    }

    @MainActor
    func getPokemonDetail() async {
        isLoading = true
        do {
            pokemonDetail = try await apiManager.request(url: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)",
                                                                 httpMethod: "GET",
                                                                 request: nil)
        } catch {

        }
        isLoading = false
    }
}
