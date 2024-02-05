//
//  PokemonType.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import SwiftData

//@Model
class PokemonType: Decodable, Identifiable {
    var type: TypeResponse

    enum CodingKeys: CodingKey {
        case type
    }

    init(type: TypeResponse) {
        self.type = type
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(TypeResponse.self, forKey: .type)
    }
}

extension PokemonType: Equatable {
    static func == (lhs: PokemonType, rhs: PokemonType) -> Bool {
        lhs.type == rhs.type
    }
}
