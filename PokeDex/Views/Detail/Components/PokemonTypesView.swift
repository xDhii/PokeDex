//
//  PokemonTypesView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import SwiftUI

struct PokemonTypesView: View {
    let types: [PokemonDetailTypes]
    let getBackgroundColor: (String) -> Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Types")
                .font(.headline)
                .fontWeight(.semibold)

            HStack {
                ForEach(types) { type in
                    Text(type.name.capitalized)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(getBackgroundColor(type.name))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(color: getBackgroundColor(type.name).opacity(0.5), radius: 4, x: 0, y: 1)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    PokemonTypesView(
        types: [
            PokemonDetailTypes(name: "electric"),
            PokemonDetailTypes(name: "fire"),
        ],
        getBackgroundColor: { type in
            switch type {
                case "electric": return .yellow
                case "fire": return .red
                default: return .gray
            }
        }
    )
}
