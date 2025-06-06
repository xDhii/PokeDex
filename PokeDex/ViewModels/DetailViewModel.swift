//
//  DetailViewModel.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class DetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var backgroundColorPokemonType: Color = .gray

    private let networkService = NetworkService.shared
    private let pokemonService = PokemonService.shared

        // MARK: - Public Methods
    func fetchPokemonDetail(for pokemon: Pokemon) async {
        isLoading = true
        errorMessage = nil

        do {
            let pokemonDetailData = try await networkService.fetchDetail(name: pokemon.data.name)

            let types = pokemonDetailData.types.map { detail in
                PokemonDetailTypes(name: detail.type.name)
            }

            let abilities = pokemonDetailData.abilities.map { $0.ability.name }

            let stats = pokemonDetailData.stats.map { stat in
                PokemonStat(name: stat.stat.name, baseStat: stat.baseStat)
            }

            pokemonDetail = PokemonDetail(
                height: pokemonDetailData.height,
                weight: pokemonDetailData.weight,
                abilities: abilities,
                stats: stats,
                types: types
            )

                // Update background color based on first type
            if let firstType = types.first {
                backgroundColorPokemonType = getBackgroundColor(for: firstType.name)
            }

        } catch {
            errorMessage = "Error loading Pokémon details: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func toggleFavorite(pokemon: Pokemon) {
        pokemonService.toggleFavorite(pokemon: pokemon)
    }

    func deletePokemon(pokemon: Pokemon) {
        pokemonService.deletePokemon(pokemon: pokemon)
    }

    func getBackgroundColor(for type: String) -> Color {
        switch type.lowercased() {
            case "bug", "grass":
                return .green
            case "fire":
                return .red
            case "electric":
                return .yellow
            case "water":
                return .blue
            case "poison":
                return .purple
            case "ground":
                return .brown
            case "flying":
                return .orange
            case "psychic", "fairy":
                return .pink
            case "fighting":
                return .red
            case "normal":
                return .gray
            case "rock":
                return .brown
            case "steel":
                return .gray
            case "ice":
                return .cyan
            case "ghost":
                return .purple
            case "dragon":
                return .blue
            case "dark":
                return .black
            default:
                return .gray
        }
    }
}
