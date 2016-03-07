//
//  CalculatorForWoodWorkerUITests.swift
//  CalculatorForWoodWorkerUITests
//
//  Created by HS Song on 2016. 3. 7..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import XCTest

class CalculatorForWoodWorkerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testCalculator() {
        let app = XCUIApplication()
        
        let textFieldQuery = app.descendantsMatchingType(.TextField)
        
        let widthTextField = textFieldQuery["woodWidth"]
        widthTextField.tap()
        widthTextField.typeText("100")

        let heightTextField = textFieldQuery["woodHeight"]
        heightTextField.tap()
        heightTextField.typeText("20")
        
        let lengthTextField = textFieldQuery["woodLength"]
        lengthTextField.tap()
        lengthTextField.typeText("2400")
        
        let priceTextField = textFieldQuery["woodPrice"]
        priceTextField.tap()
        priceTextField.typeText("15000")
        
        let tableQuery = app.descendantsMatchingType(.Table)
        let table = tableQuery.element
        table.swipeDown()
        
        let expectation = expectationWithDescription("swipe")
        expectation.fulfill()
        waitForExpectationsWithTimeout(5, handler: nil)

        snapshot("0Calculator")
    }
    
    func testConversion() {
        let app = XCUIApplication()
        
        app.tabBars.buttons.elementBoundByIndex(1).tap()

        let textFieldQuery = app.descendantsMatchingType(.TextField)
        
        let feetTextField = textFieldQuery["feetInput"]
        feetTextField.tap()
        feetTextField.typeText("1")
        
        let inchTextField = textFieldQuery["inchInput"]
        inchTextField.tap()
        inchTextField.typeText("1")
        
        let milimeterTextField = textFieldQuery["milimeterInput"]
        milimeterTextField.tap()
        milimeterTextField.typeText("330.2")
        
        let tableQuery = app.descendantsMatchingType(.Table)
        let table = tableQuery.element
        table.swipeDown()
        
        let expectation = expectationWithDescription("swipe")
        expectation.fulfill()
        waitForExpectationsWithTimeout(5, handler: nil)
        
        snapshot("0Conversion")
    }
}
