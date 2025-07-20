//
//  SearchUITests.swift
//  SearchUITests
//
//  Created by Adriano Valumin on 13/07/25.
//
import XCTest

/// UI tests to verify main search functionalities for Pokémon in the application.
final class SearchUITests: XCTestCase {
    static let app = XCUIApplication()
    let home = HomeScreen(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        SearchUITests.app.launch()
    }

    /// Checks if the search field correctly finds a Pokémon by its name.
    func testSearchBar() throws {
        // Arrange
        let pokemonName = "Bulbasaur"
        // Act
        home.searchForPokemon(pokemonName)
        // Assert
        home.validateSearchResult(pokemonName: pokemonName)
    }
}
