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
    
    static let shared = PokemonManager()
    
    private init() {
        loadFavorites()
    }
    
    func loadPokemons() async {
        guard pokemonList.isEmpty else { return }
        
        do {
            let pokemonsData = try await Network.shared.fetchList()
            let pokemons = pokemonsData.enumerated().map { index, data in
                var pokemon = Pokemon(data: data, cover: .init(indexImage: index + 1))
                pokemon.isFavorite = favoritePokemons.contains { $0.data.name == pokemon.data.name }
                return pokemon
            }
            
            pokemonList = pokemons
        } catch {
            print("Error loading pokemons: \(error)")
        }
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
        let favoriteNames = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
        // Will be populated when main list is loaded
    }
}
