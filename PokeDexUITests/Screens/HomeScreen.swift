//
//  HomeScreen.swift
//  PokeDexUITests
//
//  Created by Adriano Valumin on 13/07/25.
//

import XCTest

struct HomeScreen {
    let app: XCUIApplication
    let identifiers = AccessibilityIdentifier.self

    // MARK: - Search UI Elements

    var searchField: XCUIElement { app.textFields[identifiers.SearchBar.searchTextField] }
    var clearSearchFieldButton: XCUIElement { app.buttons[identifiers.SearchBar.clearSearchFieldButton] }

    // MARK: - Floating Icons UI Elements

    var favoritesFilterButton: XCUIElement { app.buttons[identifiers.FloatingButtons.favoritesFilterButton] }

    // MARK: - Pokemon Card UI Elements
    let test = AccessibilityIdentifier.PokemonCard.pokemonNameLabel
    var pokemonNameLabel: XCUIElement { app.staticTexts[identifiers.PokemonCard.pokemonNameLabel] }
    var favoritePokemonButton: XCUIElement { app.buttons[identifiers.PokemonCard.favoritePokemonButton] }
    var unfavoritePokemonButton: XCUIElement { app.buttons[identifiers.PokemonCard.unfavoritePokemonButton] }
    var favoritedPokemonIcon: XCUIElement { app.images[identifiers.PokemonCard.favoritedPokemonIcon] }
    var notFavoritedPokemonIcon: XCUIElement { app.images[identifiers.PokemonCard.notFavoritedPokemonIcon] }

    // MARK: - Search Actions

    func searchForPokemon(_ name: String) {
        searchField.tap()
        searchField.typeText(name)
    }

    func clearSearch() {
        clearSearchFieldButton.tap()
    }

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

    func applyFavoritesFilter() {
        favoritesFilterButton.tap()
    }
    
    func favoritePokemon() {
        favoritePokemonButton.tap()
    }
    
    func unfavoritePokemon() {
        unfavoritePokemonButton.tap()
    }
    
    // MARK: - Validations
    
    func validateFavoritedPokemonIsVisible(pokemonName: String) {
        XCTAssertTrue(pokemonNameLabel.exists)
        XCTAssertEqual(pokemonNameLabel.firstMatch.label, pokemonName)
    }
    
    func validateSearchResult(pokemonName: String) {
        XCTAssertTrue(pokemonNameLabel.exists)
        XCTAssertEqual(pokemonNameLabel.firstMatch.label, pokemonName)
        if pokemonName == "Pikachu" {
            XCTAssertNotEqual(pokemonNameLabel.label, "Bulbasaur")
        } else {
            XCTAssertNotEqual(pokemonNameLabel.label, "Pikachu")
        }
    }
}
