//
//  ResultsResponse.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import Foundation
import SwiftData

@Model
class ResultsResponse: Codable, Identifiable {
    @Attribute(.unique)
    var name: String
    var url: String
    //var detail: PokemonDetail?

    var idPokemon: Int {
        Int(url.split(separator: "/").last?.description ?? "0") ?? 0
    }

    var imageUrl: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idPokemon).png")
    }

    enum CodingKeys: CodingKey {
        case name, url, idPokemon
    }

    internal init(name: String, url: String) {
        self.name = name
        self.url = url
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
        try container.encode(idPokemon, forKey: .idPokemon)
    }

}

extension ResultsResponse: Equatable {
    static func == (lhs: ResultsResponse, rhs: ResultsResponse) -> Bool {
        lhs.idPokemon == rhs.idPokemon
    }
}
