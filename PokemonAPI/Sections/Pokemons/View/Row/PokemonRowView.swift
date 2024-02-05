//
//  PokemonRowView.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 2/02/24.
//

import SwiftUI
import Kingfisher

struct PokemonRowView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel : PokemonRowViewModel

    init(viewModel: PokemonRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            headerView
            bodyView
        }.padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width / 2 - 20,
                height: 150,
                alignment: .center)
        .background(viewModel.pokemonDetail.types.first?.type.color ?? .blue)
        .cornerRadius(10)
        .task {
            await viewModel.getPokemon()
        }
    }

    private var headerView: some View {
        HStack {
            Text(viewModel.pokemon.name.capitalized)

            Spacer()

            Text(String(viewModel.pokemon.idPokemon))
        }
        .foregroundColor(.white)
        .font(.body)
    }

    private var bodyView: some View {
        HStack {
            typesView
            imageView
        }
    }

    private var typesView: some View {
        VStack (alignment: .leading){
            ForEach(viewModel.pokemonDetail.types) { item in
                Text(item.type.name.capitalized)
                    .foregroundColor(.white)
            }
        }
    }

    private var imageView: some View {
        KFImage(viewModel.pokemon.imageUrl)
            .aspectRatio(contentMode: .fit)
            .frame(width: 80)
    }
}

#Preview {
    PokemonRowFactory.getPokemonRow(pokemon: .init(name: "Pokemon", url: ""))
}
