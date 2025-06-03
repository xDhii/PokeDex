//
//  PokemonManager.swift
//  PokeDex
//
//  Created by Adriano Valumin on 03/06/25.
//

import Foundation
import Combine

@MainActor
class PokemonManager: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var favoritePokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var hasMorePages: Bool = true

    private var currentOffset: Int = 0
    private let pageSize: Int = 20

    static let shared = PokemonManager()

    private init() {
        loadFavorites()
    }

    func loadPokemons() async {
        guard !isLoading && hasMorePages else { return }

        isLoading = true

        do {
            let pokemonsData = try await Network.shared.fetchList(offset: currentOffset, limit: pageSize)
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

    private func saveFavorites() {
        let favoriteNames = favoritePokemons.map { $0.data.name }
        UserDefaults.standard.set(favoriteNames, forKey: "favorites")
    }

    private func loadFavorites() {
        _ = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
        // Will be populated when main list is loaded
    }
}
