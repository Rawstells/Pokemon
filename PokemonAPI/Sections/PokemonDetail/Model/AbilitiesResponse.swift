//
//  AbilitiesResponse.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import Foundation

// MARK: - Ability
struct Ability: Codable, Identifiable {
    var id: String { ability.name }
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}
