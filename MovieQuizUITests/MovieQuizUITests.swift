//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Владислав on 22.06.2025.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
        app = nil
    }
    func testYesButton() {
        sleep(3)
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        app.buttons["Yes"].tap()
        sleep(3)
        let secondPoster = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        let indexLabel = app.staticTexts["Index"]
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    func testNoButton() {
        sleep(3)
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        app.buttons["No"].tap()
        sleep(3)
        let secondPoster = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        let indexLabel = app.staticTexts["Index"]
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    func testFinishGame() {
        sleep(2)
        for _ in 1...10 {
            app.buttons["Yes"].tap()
            sleep(2)
        }
        let alert = app.alerts["Game results"]
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Сыграть ещё раз")
    }
    func testAlertDismiss() {
        sleep(1)
        for _ in 1...10 {
            app.buttons["Yes"].tap()
            sleep(2)
        }
        let alert = app.alerts["Game results"]
        alert.buttons.firstMatch.tap()
        sleep(1)
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertFalse(alert.exists)
        XCTAssertTrue(indexLabel.label == "1/10")
    }
    
    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
