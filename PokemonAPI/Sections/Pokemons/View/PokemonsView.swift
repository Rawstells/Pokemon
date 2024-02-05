//
//  PokemonsView.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 2/02/24.
//


import SwiftUI
import SwiftData

struct PokemonsView: View {

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ResultsResponse.name) private var localPokemons: [ResultsResponse]
    @State private var viewModel: PokemonsViewModel = PokemonsViewModel(apiManager: APIManager())

    private var pokemons: [ResultsResponse] {
        ApiTool.isConnected ? viewModel.filteredPokemons : localPokemons
    }

    init(viewModel: PokemonsViewModel) {
        self.viewModel = viewModel
    }

    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        NavigationStack {
            VStack {
                description
                searchField
                listView
            }
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {
                    viewModel.showError = false
                }
            }
            .navigationTitle("Pokédex")
            .toolbarBackground(.visible,
                               for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }.task {
            await viewModel.getPokemons()
            //savePokemon()
        }
    }

    private var description: some View {
        Text("Use the advanced search to find Pokémon by name!")
            .font(.body)
            .fontWeight(.semibold)
            .foregroundStyle(.gray)
            .padding(.top)
            .padding(.horizontal)
    }

    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(text: $viewModel.text, label: {
                Text("Buscar pokemon")
            })
        }
        .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 0.5)
            )
        .padding(.horizontal)

    }

    private var listView: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumn,
                      spacing: 10) {
                ForEach(viewModel.filteredPokemons,
                         id: \.id) { pokemon in
                    NavigationLink {
                        PokemonDetailFactory.getPokemonDetail(pokemon: pokemon)
                    } label: {
                        PokemonRowFactory.getPokemonRow(pokemon: pokemon)
                    }
                }
            }
        }.padding()
    }

    private var navigationSplitViewDetail: some View {
        VStack {
            Text("Seleccione un Pokemon")
                .font(.largeTitle)
        }
    }

    private func savePokemon() {
        if ApiTool.isConnected {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.pokemonResponse.results.forEach {
                    modelContext.insert($0)
                }
            }
        }
    }
}

#Preview {
    PokemonsFactory.getPokemonsView()
        .modelContainer(for: ResultsResponse.self, inMemory: true)
}
