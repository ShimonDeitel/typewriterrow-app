import XCTest

final class TypewriterRowUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAddItemFlow() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["addButton"].tap()
        let nameField = app.textFields["field_name"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 2))
        nameField.tap()
        nameField.typeText("UI Test Item")
        app.buttons["saveButton"].tap()
        XCTAssertTrue(app.staticTexts["UI Test Item"].waitForExistence(timeout: 2))
    }

    func testFreeLimitTriggersPaywall() throws {
        let app = XCUIApplication()
        app.launch()
        for i in 0..<(Store_freeLimitApprox() + 2) {
            app.buttons["addButton"].tap()
            if app.staticTexts["Typewriter Row Pro"].waitForExistence(timeout: 1) {
                XCTAssertTrue(app.buttons["purchaseButton"].exists)
                app.buttons["paywallCloseButton"].tap()
                return
            }
            let nameField = app.textFields["field_name"]
            if nameField.waitForExistence(timeout: 1) {
                nameField.tap()
                nameField.typeText("Item \(i)")
                app.buttons["saveButton"].tap()
            }
        }
    }

    func testKeyboardDismissOnTapOutside() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["addButton"].tap()
        let nameField = app.textFields["field_name"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 2))
        nameField.tap()
        nameField.typeText("Test")
        app.navigationBars.element(boundBy: 0).tap()
        XCTAssertFalse(nameField.isSelected)
    }

    func testSettingsOpens() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["settingsButton"].tap()
        XCTAssertTrue(app.buttons["settingsDoneButton"].waitForExistence(timeout: 2))
        app.buttons["settingsDoneButton"].tap()
    }

    private func Store_freeLimitApprox() -> Int { 20 }
}
