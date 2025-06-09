//
//  ModernDetailView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 20/05/25.
//

import SwiftUI

struct DetailView: View {
    let pokemon: Pokemon
    @StateObject private var viewModel = DetailViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [viewModel.backgroundColorPokemonType.opacity(0.3), viewModel.backgroundColorPokemonType.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // MARK: - Header Section

                    PokemonHeaderView(
                        pokemon: pokemon,
                        backgroundColor: viewModel.backgroundColorPokemonType
                    )

                    // MARK: - Loading state

                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }

                    // MARK: - Types Section

                    if let detail = viewModel.pokemonDetail {
                        PokemonTypesView(
                            types: detail.types,
                            getBackgroundColor: viewModel.getBackgroundColor
                        )
                    }

                    // MARK: - Physical Characteristics

                    if let detail = viewModel.pokemonDetail {
                        PokemonPhysicalView(
                            height: detail.height,
                            weight: detail.weight
                        )
                    }

                    // MARK: - Abilities Section

                    if let detail = viewModel.pokemonDetail {
                        PokemonAbilitiesView(
                            abilities: detail.abilities,
                            backgroundColor: viewModel.backgroundColorPokemonType
                        )
                    }

                    // MARK: - Stats Section

                    if let detail = viewModel.pokemonDetail {
                        PokemonStatsView(
                            stats: detail.stats,
                            backgroundColor: viewModel.backgroundColorPokemonType
                        )
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button(action: toggleFavorite) {
                        Image(systemName: pokemon.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(pokemon.isFavorite ? .red : .gray)
                            .font(.title2)
                    }

                    Button(action: deletePokemon) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }
                .glassEffect(in: .capsule)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemonDetail(for: pokemon)
            }
        }
    }

    // MARK: - Actions

    private func toggleFavorite() {
        viewModel.toggleFavorite(pokemon: pokemon)
    }

    private func deletePokemon() {
        viewModel.deletePokemon(pokemon: pokemon)
        dismiss()
    }
}

#Preview {
    NavigationView {
        DetailView(
            pokemon: Pokemon(data: PokemonDTO(name: "Pikachu"), cover: PokemonCover(indexImage: 25))
        )
    }
}
