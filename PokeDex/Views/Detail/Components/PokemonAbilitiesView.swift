//
//  PokemonAbilitiesView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import SwiftUI

struct PokemonAbilitiesView: View {
    let abilities: [String]
    let backgroundColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Abilities")
                .font(.headline)
                .fontWeight(.semibold)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ], spacing: 8) {
                ForEach(abilities, id: \.self) { ability in
                    Text(ability.capitalized)
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(backgroundColor.opacity(0.2))
                        .clipShape(Capsule())
                        .shadow(color: backgroundColor.opacity(0.3), radius: 4, x: 0, y: 2)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.3))
        .glassEffect(in: .rect)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    PokemonAbilitiesView(
        abilities: ["static", "lightning-rod"],
        backgroundColor: .yellow
    )
}
