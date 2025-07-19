//
//  FavoritesUITests.swift
//  FavoritesUITests
//
//  Created by Adriano Valumin on 13/07/25.
//
import XCTest

final class FavoritesUITests: XCTestCase {
    static let app = XCUIApplication()
    let home = HomeScreen(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        FavoritesUITests.app.launch()
    }

    func testSearchBar() throws {
        let pokemonName = "Bulbasaur"
        home.searchForPokemon(pokemonName)
        home.validateSearchResult(pokemonName: pokemonName)

    }

    func testTextFavoritesFilter() throws {
        let pokemonName = "Pikachu"

        home.searchForPokemon(pokemonName)
        home.clearSearch()
        home.applyFavoritesFilter()
        
        home.validateFavoritedPokemonIsVisible(pokemonName: pokemonName)
    }
    
    func testFavoriteAndUnfavoritePokemon() {
        let pokemonName = "Pikachu"

        home.searchForPokemon(pokemonName)
        home.validateSearchedPokemon(pokemonName)
        home.favoritePokemon()
        home.unfavoritePokemon()
        
    }
}
