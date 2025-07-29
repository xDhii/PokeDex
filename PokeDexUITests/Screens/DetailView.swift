//
//  HomeScreen.swift
//  PokeDexUITests
//
//  Created by Adriano Valumin on 13/07/25.
//

import XCTest

struct DetailView {
    let app: XCUIApplication
    let home: HomeView
    let identifiers = AccessibilityIdentifier.PokemonDetailView.self

    init(app: XCUIApplication) {
        self.app = app
        self.home = HomeView(app: app)
    }

    var backButton: XCUIElement { app.buttons[identifiers.backButton] }
    var favoriteButton: XCUIElement { app.buttons[identifiers.favoriteButton] }
    var unfavoriteButton: XCUIElement { app.buttons[identifiers.unfavoriteButton] }
    var deleteButton: XCUIElement { app.buttons[identifiers.deleteButton] }
    var pokemonNameLabel: XCUIElement { app.staticTexts[identifiers.pokemonNameLabel] }
    var pokemonImage: XCUIElement { app.images[identifiers.pokemonImage] }
    var pokemonTypesList: XCUIElement { app.otherElements[identifiers.pokemonTypesList] }
    var pokemonHeightLabel: XCUIElement { app.staticTexts[identifiers.pokemonHeightLabel] }
    var pokemonWeightLabel: XCUIElement { app.staticTexts[identifiers.pokemonHeightLabel] }
    var pokemonAbilitiesList: XCUIElement { app.otherElements[identifiers.pokemonAbilitiesList] }
    var pokemonStatsBar: XCUIElement { app.otherElements[identifiers.pokemonStatsBar] }

    // MARK: - Toolbar Actions

    /// Navigates back to the previous screen by tapping the back button.
    func goBack() {
        backButton.waitAndTap()
    }

    /// Marks the current Pokémon as a favorite by tapping the favorite button.
    func tapFavoriteButton() {
        favoriteButton.waitAndTap()
    }

    /// Removes the Pokémon from favorites by tapping the unfavorite button.
    func tapUnfavoriteButton() {
        unfavoriteButton.waitAndTap()
    }

    /// Deletes the current Pokémon by tapping the delete button.
    func deletePokemon() {
        deleteButton.waitAndTap()
    }

    // MARK: - Validations

    /// Asserts that the Pokémon detail is not visible, confirming the home screen is displayed.
    func validateHomeScreenIsVisible() {
        XCTAssertFalse(pokemonNameLabel.exists)
    }

    /// Asserts that the Pokémon is marked as favorite by checking the existence of the unfavorite button and the absence of the favorite button.
    func validatePokemonIsFavorite() {
        XCTAssertTrue(unfavoriteButton.exists)
        XCTAssertFalse(favoriteButton.exists)
    }

    /// Asserts that the Pokémon is not marked as favorite by checking the existence of the favorite button and the absence of the unfavorite button.
    func validatePokemonIsNotFavorite() {
        XCTAssertTrue(favoriteButton.exists)
        XCTAssertFalse(unfavoriteButton.exists)
    }

    /// Verifies that a Pokémon was deleted by asserting the stats bar is absent, clearing the search, searching for the Pokémon by name, and ensuring the search result is empty.
    ///
    /// - Parameter pokemonName: The name of the Pokémon to verify deletion.
    func validatePokemonWasDeleted(pokemonName: String) {
        XCTAssertFalse(pokemonStatsBar.exists)
        home.clearSearch()
        home.searchForPokemon(pokemonName)
        home.validateSearchResultIsEmpty()
    }

    /// Asserts that all key elements of the Pokémon detail view are visible, confirming the detail screen is correctly displayed.
    func validatePokemonDetailsVisible() {
        pokemonNameLabel.waitUntilExists()
        XCTAssertTrue(pokemonNameLabel.exists)
        XCTAssertTrue(pokemonTypesList.exists)
        XCTAssertTrue(pokemonHeightLabel.exists)
        XCTAssertTrue(pokemonWeightLabel.exists)
        XCTAssertTrue(pokemonAbilitiesList.exists)
        XCTAssertTrue(pokemonStatsBar.exists)
    }
}
