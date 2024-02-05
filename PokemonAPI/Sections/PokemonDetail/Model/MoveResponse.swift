//
//  MoveResponse.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 5/02/24.
//

import Foundation

// MARK: - Move
struct Move: Codable, Identifiable {
    var id: String { move.name }
    let move: Species
}
