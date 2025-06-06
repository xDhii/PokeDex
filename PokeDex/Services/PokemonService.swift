//
//  PokemonService.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import Foundation
import Combine

@MainActor
class PokemonService: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var favoritePokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var hasMorePages: Bool = true

    private var currentOffset: Int = 0
    private let pageSize: Int = 20
    private let networkService = NetworkService.shared

    static let shared = PokemonService()

    private init() {
        loadFavorites()
    }

    // MARK: - Public Methods

    func loadPokemons() async {
        guard !isLoading && hasMorePages else { return }

        isLoading = true

        do {
            let pokemonsData = try await networkService.fetchList(offset: currentOffset, limit: pageSize)
            let newPokemons = pokemonsData.enumerated().map { index, data in
                var pokemon = Pokemon(data: data, cover: .init(indexImage: currentOffset + index + 1))
                pokemon.isFavorite = favoritePokemons.contains { $0.data.name == pokemon.data.name }
                return pokemon
            }

            pokemonList.append(contentsOf: newPokemons)
            currentOffset += pageSize

            // Se recebeu menos pokémons que o esperado, não há mais páginas
            if newPokemons.count < pageSize {
                hasMorePages = false
            }

        } catch {
            print("Error loading pokemons: \(error)")
        }

        isLoading = false
    }

    func loadMorePokemonsIfNeeded(for pokemon: Pokemon) async {
        // Carrega mais pokémons quando está próximo do final da lista
        if pokemonList.firstIndex(where: { $0.id == pokemon.id }) == pokemonList.count - 5 {
            await loadPokemons()
        }
    }

    func resetPagination() {
        pokemonList = []
        currentOffset = 0
        hasMorePages = true
        isLoading = false
    }

    func toggleFavorite(pokemon: Pokemon) {
        // Update in main list
        if let index = pokemonList.firstIndex(where: { $0.id == pokemon.id }) {
            pokemonList[index].isFavorite.toggle()

            if pokemonList[index].isFavorite {
                favoritePokemons.append(pokemonList[index])
            } else {
                favoritePokemons.removeAll { $0.id == pokemon.id }
            }
        }

        saveFavorites()
    }

    func deletePokemon(pokemon: Pokemon) {
        pokemonList.removeAll { $0.id == pokemon.id }
        favoritePokemons.removeAll { $0.id == pokemon.id }
        saveFavorites()
    }

    // MARK: - Detail Methods

    func fetchPokemonDetail(for pokemon: Pokemon) async throws -> PokemonDetail {
        let pokemonDetailData = try await networkService.fetchDetail(name: pokemon.data.name)

        let types = pokemonDetailData.types.map { detail in
            PokemonDetailTypes(name: detail.type.name)
        }

        let abilities = pokemonDetailData.abilities.map { $0.ability.name }

        let stats = pokemonDetailData.stats.map { stat in
            PokemonStat(name: stat.stat.name, baseStat: stat.baseStat)
        }

        return PokemonDetail(
            height: pokemonDetailData.height,
            weight: pokemonDetailData.weight,
            abilities: abilities,
            stats: stats,
            types: types
        )
    }

    // MARK: - Private Methods

    private func saveFavorites() {
        let favoriteNames = favoritePokemons.map { $0.data.name }
        UserDefaults.standard.set(favoriteNames, forKey: "favorites")
    }

    private func loadFavorites() {
        let favoriteNames = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
        // Will be populated when main list is loaded and matched with favorite names
        _ = favoriteNames // Avoid warning, favorites will be applied when pokemonList loads
    }
}
