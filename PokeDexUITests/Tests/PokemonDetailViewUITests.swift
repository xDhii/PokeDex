//
//  PokemonDetailViewUITests.swift
//  PokeDexUITests
//
//  Created by Adriano Valumin on 28/07/25.
//

import XCTest

final class PokemonDetailViewUITests: XCTestCase {
    static let app = XCUIApplication()
    let home = HomeView(app: app)
    let pokemonDetails = DetailView(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        FavoritesUITests.app.launch()
    }

    /// Tests that searching for a Pokémon and tapping it navigates to the detail view, which correctly displays the Pokémon details.
    func testPokemonDetailsAreVisible() throws {
        // Arrange
        let pokemonName = "Bulbasaur"

        // Act
        home.searchForPokemon(pokemonName)
        home.navigateToPokemonDetailView()

        // Assert
        pokemonDetails.validatePokemonDetailsVisible()
    }

    /// Tests that deleting a Pokémon from its detail view removes it and verifies that the Pokémon no longer appears in the list.
    func testDeletePokemon() throws {
        // Arrange
        let pokemonName = "Bulbasaur"

        // Act
        home.searchForPokemon(pokemonName)
        home.navigateToPokemonDetailView()
        pokemonDetails.deletePokemon()

        // Assert
        pokemonDetails.validatePokemonWasDeleted(pokemonName: pokemonName)
    }

    /// Tests that favoriting a Pokémon from its detail view marks it as a favorite and reflects the favorite state.
    func testFavoritesInsideDetailView() throws {
        // Arrange
        let pokemonName = "Pikachu"

        // Act
        home.searchForPokemon(pokemonName)
        home.navigateToPokemonDetailView()
        pokemonDetails.tapFavoriteButton()

        // Assert
        pokemonDetails.validatePokemonIsFavorite()
    }

    /// Tests that unfavoriting a Pokémon from its detail view removes it from favorites and updates the favorite state accordingly.
    func testUnfavoriteInsideDetailView() throws {
        // Arrange
        let pokemonName = "Pikachu"

        // Act
        home.searchForPokemon(pokemonName)
        home.navigateToPokemonDetailView()
        pokemonDetails.tapFavoriteButton()
        pokemonDetails.tapUnfavoriteButton()

        // Assert
        pokemonDetails.validatePokemonIsNotFavorite()
    }

    /// Tests that a Pokémon marked as favorite in the detail view remains favorited after navigating back to the Home screen and searching again.
    func testFavoritesBetweenScreens() throws {
        // Arrange
        let pokemonName = "Pikachu"

        // Act
        home.searchForPokemon(pokemonName)
        home.navigateToPokemonDetailView()
        pokemonDetails.tapFavoriteButton()
        pokemonDetails.goBack()
        home.clearSearch()
        home.searchForPokemon(pokemonName)

        // Assert
        home.validateFavoritedPokemonIsVisible(pokemonName: pokemonName)
    }

    /// Tests that a Pokémon unfavorited in the detail view is no longer shown as favorite after navigating back to the Home screen and searching again.
    func testUnfavoriteBetweenScreens() throws {
        let pokemonName = "Pikachu"
        
        home.searchForPokemon(pokemonName)
        home.navigateToPokemonDetailView()
        pokemonDetails.tapFavoriteButton()
        pokemonDetails.tapUnfavoriteButton()
        pokemonDetails.goBack()
        home.clearSearch()
        home.searchForPokemon(pokemonName)

        // Assert
        home.validateNoFavoritePokemonIsVisible()
    }
}

