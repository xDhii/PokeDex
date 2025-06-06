//
//  ModernPokemonCard.swift
//  PokeDex
//
//  Created by Adriano Valumin on 03/06/25.
//

import SwiftUI

struct ModernPokemonCard: View {
    let pokemon: Pokemon
    @StateObject private var pokemonService = PokemonService.shared

    var body: some View {
        VStack(spacing: 0) {
            // Pokemon image with gradient background
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.3),
                        Color.purple.opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Pokemon image
                AsyncImage(url: pokemon.cover.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray5))
                        .frame(width: 100, height: 100)
                        .overlay(
                            ProgressView()
                                .scaleEffect(0.7)
                        )
                }

                // Favorite button
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            pokemonService.toggleFavorite(pokemon: pokemon)
                        }) {
                            Image(systemName: pokemon.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(pokemon.isFavorite ? .red : .white)
                                .font(.system(size: 16, weight: .semibold))
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                        }
                        .padding(8)
                    }
                    Spacer()
                }
            }
            .frame(height: 120)

            // Pokemon info
            VStack(spacing: 4) {
                Text(pokemon.data.name.capitalized)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text("#\(String(format: "%03d", pokemon.cover.indexImage))")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .scaleEffect(1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: pokemon.isFavorite)
    }
}

#Preview {
    ModernPokemonCard(
        pokemon: Pokemon(data: PokemonDTO(name: "Pikachu"), cover: PokemonCover(indexImage: 25))
    )
    .frame(width: 160)
    .padding()
}
