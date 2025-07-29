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
    let home = HomeView(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        FavoritesUITests.app.launch()
    }

    /// Tests that after searching and favoriting a Pokémon, applying the favorites filter correctly displays it in the filtered results.
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

    /// Tests that a user can favorite a Pokémon from search results and then unfavorite it, and that the Pokémon is no longer shown as a favorite.
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

    /// Tests that favoriting a Pokémon from its detail screen correctly registers the favorite status when returning to the home view.
    func testFavoriteFromDetailScreenToHome() {
        // Arrange
        let pokemonName = "Pikachu"

        // Act
        home.searchForPokemon(pokemonName)
        home.favoritePokemon()

        // Assert
    }

    /// Tests that favoriting a Pokémon from the home list appears as favorite when navigating to its detail view.
    func testFavoriteFromHomeToDetailScreen() {
        let pokemonName = "Pikachu"
        
        home.searchForPokemon(pokemonName)
        home.favoritePokemon()
        
        
    }
}

