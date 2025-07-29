//
//  PokemonHeaderView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import SwiftUI

struct PokemonHeaderView: View {
    let pokemon: Pokemon
    let backgroundColor: Color
    let identifiers = AccessibilityIdentifier.PokemonDetailView.self

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: pokemon.cover.image) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(1.18)
                    .accessibilityIdentifier(identifiers.pokemonImage)

            }
            .frame(width: 200, height: 200)
            .background(
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.gray.opacity(0.1),
                                backgroundColor.opacity(0.4),
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: backgroundColor.opacity(0.3), radius: 10, x: 0, y: 5)
                    .glassEffect(in: .circle)
            )

            Text(pokemon.data.name.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .accessibilityIdentifier(identifiers.pokemonNameLabel)
        }
        .padding(.top)
    }
}

#Preview {
    PokemonHeaderView(
        pokemon: Pokemon(
            data: PokemonDTO(name: "pikachu"),
            cover: PokemonCover(indexImage: 25)
        ),
        backgroundColor: .yellow
    )
}
