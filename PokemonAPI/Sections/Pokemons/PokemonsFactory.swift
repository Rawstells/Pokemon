//
//  PokemonsFactory.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

enum PokemonsFactory {
    static func getPokemonsView() -> PokemonsView {
        let apiManager = APIManager()
        let viewModel = PokemonsViewModel(apiManager: apiManager)
        return PokemonsView(viewModel: viewModel)
    }
}
