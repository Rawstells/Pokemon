//
//  PokemonRowFactory.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

enum PokemonRowFactory {
    static func getPokemonRow(pokemon: ResultsResponse) -> PokemonRowView {
        let apiManager = APIManager()
        let viewModel = PokemonRowViewModel(pokemon: pokemon, apiManager: apiManager)
        return PokemonRowView(viewModel: viewModel)
    }
}
