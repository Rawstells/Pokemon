//
//  PokemonResponse.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 2/02/24.
//

import Foundation
import SwiftData

//@Model
final class PokemonResponse: Codable {
    var results: [ResultsResponse]

    enum CodingKeys: CodingKey {
        case results
    }

    init(results: [ResultsResponse]) {
        self.results = results
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([ResultsResponse].self, forKey: .results)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
    }
}

extension PokemonResponse: Equatable {
    static func == (lhs: PokemonResponse, rhs: PokemonResponse) -> Bool {
        lhs.results == rhs.results
    }
}
