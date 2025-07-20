//
//  FavoritesUITests.swift
//  FavoritesUITests
//
//  Created by Adriano Valumin on 13/07/25.
//
import XCTest

/// UI tests to verify the main functionalities related to favoriting and filtering Pokémon in the application.
final class FavoritesUITests: XCTestCase {
    static let app = XCUIApplication()
    let home = HomeScreen(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        FavoritesUITests.app.launch()
    }

    /// Checks if the favorites filter correctly displays a favorited Pokémon after searching and favoriting it.
    func testTextFavoritesFilter() throws {
        // Arrange
        let pokemonName = "Pikachu"

        // Act
        home.searchForPokemon(pokemonName)
        home.favoritePokemon()
        home.clearSearch()
        home.applyFavoritesFilter()

        // Assert
        home.validateFavoritedPokemonIsVisible(pokemonName: pokemonName)
    }

    /// Checks if a Pokémon can be favorited and then unfavorited after searching.
    func testFavoriteAndUnfavoriteSearchedPokemon() {
        // Arrange
        let pokemonName = "Pikachu"

        // Act
        home.searchForPokemon(pokemonName)
        home.validateSearchedPokemon(pokemonName)
        home.favoritePokemon()
        home.unfavoritePokemon()

        // Assert
        home.validateNoFavoritePokemonIsVisible()
    }
}
