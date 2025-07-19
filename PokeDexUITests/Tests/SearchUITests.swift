//
//  SearchUITests.swift
//  SearchUITests
//
//  Created by Adriano Valumin on 13/07/25.
//
import XCTest

final class SearchUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testSearchBar() throws {
        let searchField = app.textFields["searchTextField"]
        let pokemonName = app.staticTexts["pokemonNameLabel"]
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("Pikachu")

        XCTAssertTrue(pokemonName.exists)
        XCTAssertEqual(pokemonName.label, "Pikachu")
        XCTAssertNotEqual(pokemonName.label, "Bulbasaur")
    }

    func testTextFavoritesFilter() throws {
        let searchField = app.textFields["searchTextField"]
        let pokemonName = app.staticTexts["pokemonNameLabel"]
        let favoritePokemonButton = app.buttons["favoritePokemonButton"]
        let favoritesFilterButton = app.buttons["favoritesFilterButton"]
        let clearSearchFieldButton = app.buttons["clearSearchFieldButton"]

        searchField.tap()
        searchField.typeText("Pikachu")
        favoritePokemonButton.tap()
        clearSearchFieldButton.tap()
        favoritesFilterButton.tap()

        XCTAssertTrue(pokemonName.exists)
        XCTAssertEqual(pokemonName.firstMatch.label, "Pikachu")
    }


}
