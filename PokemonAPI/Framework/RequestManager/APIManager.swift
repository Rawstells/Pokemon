//
//  APIMAnager.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 2/02/24.
//

import Foundation

protocol APIManagerProtocol {
    func request<T: Decodable>(url: String,
                                             httpMethod: String,
                                             request: Encodable?) async throws -> T
}

class APIManager: APIManagerProtocol {
    public func request<T: Decodable>(url: String,
                                             httpMethod: String,
                                             request: Encodable?) async throws -> T {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    public static func requestPokemons(url: String,
                                                     httpMethod: String,
                                                     request: Encodable?) async throws -> PokemonResponse {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let pokemon = try JSONDecoder().decode(PokemonResponse.self, from: data)
        for resultResponse in pokemon.results {
            let _: PokemonDetail = try! await APIManager().request(url: "https://pokeapi.co/api/v2/pokemon/\(resultResponse.name)", httpMethod: "GET", request: nil)
            //resultResponse.detail = pokemonDetail
        }
        return pokemon
    }
}
