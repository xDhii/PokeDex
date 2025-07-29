//
//  AccessibilityIdentifier.swift
//  PokeDex
//
//  Created by Adriano Valumin on 15/07/25.
//

import Foundation

enum AccessibilityIdentifier {
    // MARK: - Pokemon Card UI Elements

    enum PokemonCard {
        static let pokemonNameLabel = "pokemonNameLabel"
        static let pokemonCard = "pokemonCard"
        static let favoritePokemonButton = "favoritePokemonButton"
        static let unfavoritePokemonButton = "unfavoritePokemonButton"
        static let favoritedPokemonIcon = "favoritedPokemonIcon"
        static let notFavoritedPokemonIcon = "notFavoritedPokemonIcon"
    }

    // MARK: - Search UI Elements

    enum SearchBar {
        static let searchTextField = "searchTextField"
        static let clearSearchFieldButton = "clearSearchFieldButton"
    }

    // MARK: - Floating Icons UI Elements

    enum FloatingButtons {
        static let favoritesFilterButton = "favoritesFilterButton"
    }

    // MARK: - Pokemon Detail View

    enum PokemonDetailView {
        // MARK: - Toolbar

        static let backButton = "backButton"
        static let favoriteButton = "favoriteButton"
        static let unfavoriteButton = "unfavoriteButton"
        static let deleteButton = "deleteButton"

        // MARK: - Header

        static let pokemonNameLabel = "pokemonNameLabel"
        static let pokemonImage = "pokemonImage"

        // MARK: - Pokemon Types

        static let pokemonTypesList = "pokemonTypeList"

        // MARK: - Physical Characteristics

        static let pokemonHeightLabel = "pokemonHeightLabel"
        static let pokemonWeightLabel = "pokemonWeightLabel"

        // MARK: - Pokemon Abilities

        static let pokemonAbilitiesList = "pokemonAbilitiesList"

        // MARK: - Pokemon Base Stats

        static let pokemonStatsBar = "pokeballStatsBar"
    }
}
