//
//  MathTests.swift
//  MathTests
//
//  Created by Robert Berry on 7/23/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import XCTest
@testable import Math

// Clicking the diamond next to class will run all the test cases in that class.

// Clicking the diamond next to an individual test, will allow for just that test to be run.

class MathTests: XCTestCase {
    
    // MARK: Properties
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewController = ViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSquare() {
        
        let square = viewController.square(number: 100)
        
        XCTAssertEqual(square, 10000 , "The square of 100 is 10,000")
        
    }
    
    func testcube() {
        
        let cube = viewController.cube(number: 10)
        
        XCTAssertEqual(cube, 1000 , "The cube of 10 is 1,000")
        
    }
    
    func testSquareRoot() {
        
        let squareRoot = viewController.squareRoot(number: 144)
        
        XCTAssertEqual(squareRoot, 12, "The square root of 144 is 12")
        
    }
}
