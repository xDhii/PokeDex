//
//  AccessibilityIdentifier.swift
//  PokeDex
//
//  Created by Adriano Valumin on 15/07/25.
//

import Foundation

enum AccessibilityIdentifier {
    enum PokemonCard {
        static let pokemonNameLabel = "pokemonNameLabel"
        static let pokemonCard = "pokemonCard"
        static let favoritePokemonButton = "favoritePokemonButton"
        static let unfavoritePokemonButton = "unfavoritePokemonButton"
        static let favoritedPokemonIcon = "favoritedPokemonIcon"
        static let notFavoritedPokemonIcon = "notFavoritedPokemonIcon"
    }
    
    enum SearchBar {
        static let searchTextField = "searchTextField"
        static let clearSearchFieldButton = "clearSearchFieldButton"
    }
    
    enum FloatingButtons {
        static let favoritesFilterButton = "favoritesFilterButton"
    }
    
}
