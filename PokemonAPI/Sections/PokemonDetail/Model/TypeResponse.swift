//
//  TypeResponse.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import SwiftUI
import SwiftData

//@Model
class TypeResponse: Decodable {
    var name: String

    enum CodingKeys: CodingKey {
        case name
    }

    init(name: String) {
        self.name = name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
}

extension TypeResponse: Equatable {
    static func == (lhs: TypeResponse, rhs: TypeResponse) -> Bool {
        lhs.name == rhs.name &&
        lhs.color == rhs.color
    }
}

extension TypeResponse {
    var color: Color {
        switch name {
        case "grass": return Color.lightGreen
        case "poison": return Color.lightPurple
        case "fire": return Color.lightRed
        case "flying": return Color.lilac
        case "water": return Color.lightBlue
        case "bug": return Color.lightTeal
        case "normal": return Color.beige
        case "electric": return Color.lightYellow
        case "ground": return Color.darkBrown
        case "fairy": return Color.pink
        case "fighting": return Color.red
        case "psychic": return Color.lightPink
        case "rock": return Color.lightBrown
        case "steel": return Color.grey
        case "ice": return Color.lightCyan
        case "ghost": return Color.purple
        case "dragon": return Color.violet
        case "dark": return Color.black
        case "monster": return Color.lightBlue
        case "unknown": return Color.lightBlue
        default: return Color.blue
        }
    }
}
