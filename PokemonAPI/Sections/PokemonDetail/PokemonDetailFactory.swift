//
//  PokemonDetailFactory.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

enum PokemonDetailFactory {
    static func getPokemonDetail(pokemon: ResultsResponse) -> PokemonDetailView {
        let apiManager = APIManager()
        let viewModel = PokemonDetailViewModel(pokemon: pokemon, apiManager: apiManager)
        return PokemonDetailView(viewModel: viewModel)
    }
}
