//
//  MathUITests.swift
//  MathUITests
//
//  Created by Robert Berry on 7/23/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import XCTest

class MathUITests: XCTestCase {
    
    override func setUp() {
       
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
       
        continueAfterFailure = false
       
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
       
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSquareButtonTapped() {
        
        let app = XCUIApplication()
        
        app.textFields["InputTextField"].tap()
        
        app.textFields["InputTextField"].typeText("100")
        
        app.buttons["Square"].tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // staticTexts determines if that label text exists. 
        
        XCTAssert(app.staticTexts["10000.0"].exists)
    }
 
    func testCubeButtonTapped() {
        
        let app = XCUIApplication()
        
        app.textFields["InputTextField"].tap()
        
        app.textFields["InputTextField"].typeText("100")
        
        app.buttons["Cube"].tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(app.staticTexts["1000000.0"].exists)
    }
    
    func testSquareRootButtonTapped() {
        
        let app = XCUIApplication()
        
        app.textFields["InputTextField"].tap()
        
        app.textFields["InputTextField"].typeText("169")
        
        app.buttons["Square Root"].tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(app.staticTexts["13.0"].exists)
        
    }
}


