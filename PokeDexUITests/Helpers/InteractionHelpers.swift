//
//  InteractionHelpers.swift
//  PokeDexUITests
//
//  Created by Adriano Valumin on 13/07/25.
//

import XCTest

extension XCUIElement {
    func waitAndtapAndType(_ text: String, timeout: TimeInterval = 8) {
        XCTAssertTrue(self.waitForExistence(timeout: timeout), "Element not visible")
        self.tap()
        self.typeText(text)
    }
    
    func waitAndTap(_ text: String, timeout: TimeInterval = 8) {
        XCTAssertTrue(self.waitForExistence(timeout: timeout), "Element not visible")
        self.tap()
    }
}
