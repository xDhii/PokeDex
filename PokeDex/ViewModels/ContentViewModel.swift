//
//  ContentViewModel.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import Combine
import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var favoritePokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var hasMorePages: Bool = true
    @Published var searchText: String = ""
    @Published var showingFavoritesOnly: Bool = false
    @Published var selectedGeneration: Int = 1

    private let pokemonService = PokemonService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Bind service properties to ViewModel
        pokemonService.$pokemonList
            .assign(to: &$pokemons)

        pokemonService.$favoritePokemons
            .assign(to: &$favoritePokemons)

        pokemonService.$isLoading
            .assign(to: &$isLoading)

        pokemonService.$hasMorePages
            .assign(to: &$hasMorePages)
    }

    // MARK: - Public Methods

    func loadPokemons() async {
        await pokemonService.loadPokemons()
    }

    func loadMorePokemonsIfNeeded(for pokemon: Pokemon) async {
        await pokemonService.loadMorePokemonsIfNeeded(for: pokemon)
    }

    func resetPagination() {
        pokemonService.resetPagination()
    }

    func toggleFavorite(pokemon: Pokemon) {
        pokemonService.toggleFavorite(pokemon: pokemon)
    }

    func deletePokemon(pokemon: Pokemon) {
        pokemonService.deletePokemon(pokemon: pokemon)
    }

    // MARK: - Computed Properties

    var filteredPokemons: [Pokemon] {
        let list = showingFavoritesOnly ? favoritePokemons : pokemons

        if searchText.isEmpty {
            return list
        } else {
            return list.filter { $0.data.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
