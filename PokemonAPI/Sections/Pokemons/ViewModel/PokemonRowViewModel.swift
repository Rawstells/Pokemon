//
//  PokemonRowViewModel.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import Foundation

@Observable class PokemonRowViewModel {

    var apiManager: APIManagerProtocol
    var pokemon: ResultsResponse
    var pokemonDetail: PokemonDetail = .init(types: [], abilities: [], moves: [])

    init(pokemon: ResultsResponse, apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
        self.pokemon = pokemon
    }


    func getPokemon() async {
        if !ApiTool.isConnected {
            return
        }
        do {
            pokemonDetail = try await apiManager.request(url: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)", httpMethod: "GET", request: nil)
            print(pokemonDetail)
        } catch {
            print(error.localizedDescription)
        }
    }
}
