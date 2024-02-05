//
//  ProgressCustomView.swift
//  PokemonAPI
//
//  Created by Joan Narvaez on 4/02/24.
//

import SwiftUI

struct ProgressCustomView: View {
    var body: some View {
        ProgressView {
            Text("Loading")
                .foregroundColor(.pink)
                .bold()
        }
    }
}

#Preview {
    ProgressCustomView()
}
