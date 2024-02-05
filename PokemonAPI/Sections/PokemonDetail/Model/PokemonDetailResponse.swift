//
//  PokemonDetailResponse.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import SwiftData

//@Model
class PokemonDetail: Decodable {
    var types: [PokemonType]
    var abilities: [Ability]
    var moves: [Move]

    internal init(types: [PokemonType], abilities: [Ability], moves: [Move]) {
        self.types = types
        self.abilities = abilities
        self.moves = moves
    }
}

extension PokemonDetail: Equatable {
    static func == (lhs: PokemonDetail, rhs: PokemonDetail) -> Bool {
        lhs.types == rhs.types
    }
}
