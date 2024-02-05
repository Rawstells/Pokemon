//
//  Color+Hex.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import SwiftUI

public extension Color {
    init?(hex: String,
          alpha: Double = 1) {
        guard let uint = UInt(("0x" + hex).suffix(6), radix: 16) else {
            return nil
        }
        self.init(hex: uint, alpha: alpha)
    }

    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xff) / 255,
                  green: Double((hex >> 08) & 0xff) / 255,
                  blue: Double((hex >> 00) & 0xff) / 255,
                  opacity: alpha)
    }
}
