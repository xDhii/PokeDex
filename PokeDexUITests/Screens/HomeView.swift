//
//  HomeScreen.swift
//  PokeDexUITests
//
//  Created by Adriano Valumin on 13/07/25.
//

import XCTest

struct HomeView {
    let app: XCUIApplication
    let identifiers = AccessibilityIdentifier.self

    // MARK: - Search UI Elements

    var searchField: XCUIElement { app.textFields[identifiers.SearchBar.searchTextField] }
    var clearSearchFieldButton: XCUIElement { app.buttons[identifiers.SearchBar.clearSearchFieldButton] }

    // MARK: - Floating Icons UI Elements

    var favoritesFilterButton: XCUIElement { app.buttons[identifiers.FloatingButtons.favoritesFilterButton] }

    // MARK: - Pokemon Card UI Elements

    var pokemonCard: XCUIElement { app.otherElements[identifiers.PokemonCard.pokemonCard]}
    var pokemonNameLabel: XCUIElement { app.staticTexts[identifiers.PokemonCard.pokemonNameLabel] }
    var favoritePokemonButton: XCUIElement { app.buttons[identifiers.PokemonCard.favoritePokemonButton] }
    var unfavoritePokemonButton: XCUIElement { app.buttons[identifiers.PokemonCard.unfavoritePokemonButton] }
    var favoritedPokemonIcon: XCUIElement { app.images[identifiers.PokemonCard.favoritedPokemonIcon] }
    var notFavoritedPokemonIcon: XCUIElement { app.images[identifiers.PokemonCard.notFavoritedPokemonIcon] }

    // MARK: - Search Actions

    /// Searches for a Pokémon by name using the search field.
    /// - Parameter name: The name of the Pokémon to search for.
    func searchForPokemon(_ name: String) {
        searchField.waitAndTap()
        searchField.waitAndtapAndType(name)
    }

    /// Clears the search field using the clear button.
    func clearSearch() {
        clearSearchFieldButton.waitAndTap()
    }

    /// Validates if the searched Pokémon is present in the search results.
    /// - Parameter pokemonName: The expected Pokémon name in the results.
    func validateSearchedPokemon(_ pokemonName: String) {
        // Validation when a single card is returned
        XCTAssertTrue(pokemonNameLabel.exists)
        XCTAssertEqual(pokemonNameLabel.firstMatch.label, pokemonName)

        // Validation when multiple cards are returned
        let allLabels = app.staticTexts.matching(identifier: AccessibilityIdentifier.PokemonCard.pokemonNameLabel).allElementsBoundByIndex
        let exists = allLabels.contains { $0.label == pokemonName }
        XCTAssertTrue(exists, "Pokemon '\(pokemonName)' not found in search results")
    }

    // MARK: - Favorites Actions

    /// Applies the filter to show only favorited Pokémon.
    func applyFavoritesFilter() {
        favoritesFilterButton.waitAndTap()
    }

    /// Marks the current Pokémon as favorited.
    func favoritePokemon() {
        favoritePokemonButton.waitAndTap()
    }

    /// Removes the favorite mark from the current Pokémon.
    func unfavoritePokemon() {
        unfavoritePokemonButton.waitAndTap()
    }

    func navigateToPokemonDetailView() {
        pokemonNameLabel.waitAndTap()
    }

    // MARK: - Validations

    /// Validates if the favorited Pokémon is visible on the screen.
    /// - Parameter pokemonName: The name of the Pokémon that should be visible.
    func validateFavoritedPokemonIsVisible(pokemonName: String) {
        XCTAssertTrue(pokemonNameLabel.exists)
        XCTAssertEqual(pokemonNameLabel.firstMatch.label, pokemonName)
    }

    /// Validates the search result to ensure the correct Pokémon is listed and that a different Pokémon is not displayed.
    /// - Parameter pokemonName: The expected Pokémon name in the search results.
    func validateSearchResultIsVisible(pokemonName: String) {
        XCTAssertTrue(pokemonNameLabel.exists)
        XCTAssertEqual(pokemonNameLabel.firstMatch.label, pokemonName)
        if pokemonName == "Pikachu" {
            XCTAssertNotEqual(pokemonNameLabel.label, "Bulbasaur")
        } else {
            XCTAssertNotEqual(pokemonNameLabel.label, "Pikachu")
        }
    }

    func validateSearchResultIsEmpty() {
        XCTAssertFalse(pokemonCard.exists)
    }

    /// Validates that no unfavorited Pokémon is visible and that the favorite button is present.
    /// Use this after to validate that no favorite pokemons are visible.
    func validateNoFavoritePokemonIsVisible() {
        XCTAssertFalse(unfavoritePokemonButton.exists)
        XCTAssertTrue(favoritePokemonButton.exists)
    }
}
