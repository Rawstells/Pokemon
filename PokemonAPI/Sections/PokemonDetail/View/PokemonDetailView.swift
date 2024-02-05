//
//  PokemonDetailView.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 3/02/24.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    @State private var viewModel: PokemonDetailViewModel

    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
    }

    private let adaptiveColumn = [GridItem(), GridItem()]

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressCustomView()
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        image
                        types
                        abilities
                        moves
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea(.container)
        .navigationTitle(viewModel.pokemon.name.capitalized)
        .toolbarBackground(.visible,
                           for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task {
            await viewModel.getPokemonDetail()
        }
    }

    private var image: some View {
        KFImage(viewModel.pokemon.imageUrl)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width)
            .padding(.top, 120)
            .background(viewModel.pokemonDetail.types.first?.type.color ?? .blue)
    }

    @ViewBuilder
    private var types: some View {
        Text("Types")
            .font(.title3)
            .fontWeight(.bold)
            .padding(.leading)

        LazyVGrid(columns: adaptiveColumn,
                  spacing: .zero) {
            ForEach(viewModel.pokemonDetail.types) { item in
                Text(item.type.name)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.red, lineWidth: 0.5)
                    )
            }
        }
    }

    @ViewBuilder
    private var abilities: some View {
        Text("Abilities")
            .font(.title3)
            .fontWeight(.bold)
            .padding(.leading)

        ForEach(viewModel.pokemonDetail.abilities) { item in
            Text(item.ability.name)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.green, lineWidth: 0.5)
                )
                .padding(.leading)
                .padding(.bottom)
        }
    }

    @ViewBuilder
    private var moves: some View {
        Text("Moves")
            .font(.title3)
            .fontWeight(.bold)
            .padding(.leading)

        LazyVGrid(columns: [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())],
                  spacing: 15) {
            ForEach(viewModel.pokemonDetail.moves) { item in
                VStack(alignment: .leading) {
                    Text(" - " + item.move.name)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    PokemonDetailFactory.getPokemonDetail(pokemon: .init(name: "Pokemon", url: ""))
}
