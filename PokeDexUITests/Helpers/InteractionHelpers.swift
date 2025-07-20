//
//  InteractionHelpers.swift
//  PokeDexUITests
//
//  Created by Adriano Valumin on 13/07/25.
//

import XCTest

extension XCUIElement {
    /// Waits for the element to appear, taps it, and types the given text followed by a Return (to dismiss the keyboard).
    /// - Parameters:
    ///   - text: The text to type into the element.
    ///   - timeout: The timeout to wait for the element to exist (in seconds). Default is 8 seconds.
    ///
    /// This helper method is useful for interacting with text input elements in UI tests.
    func waitAndtapAndType(_ text: String, timeout: TimeInterval = 8) {
        XCTAssertTrue(self.waitForExistence(timeout: timeout), "Element not visible")
        self.tap()
        self.typeText("\(text)\n")
    }
    
    /// Waits for the element to appear and then taps it.
    /// - Parameter timeout: The timeout to wait for the element to exist (in seconds). Default is 8 seconds.
    ///
    /// Use this helper to safely tap elements that may not be immediately present on the screen in UI tests.
    func waitAndTap(timeout: TimeInterval = 8) {
        XCTAssertTrue(self.waitForExistence(timeout: timeout), "Element not visible")
        self.tap()
    }
}
