//
//  BlueLibraryUITests.swift
//  BlueLibrarySwiftUITests
//
//  Created by Igor Balagurov on 16/08/2018.
//  Copyright © 2018 Raywenderlich. All rights reserved.
//

import XCTest


class BlueLibraryUITests: XCTestCase {
    let app = XCUIApplication()
    let mainScreen = MainScreen()

        
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        while mainScreen.undo.isEnabled {
            mainScreen.undo.tap()
        }
    }
    
    func testDeleteAlbum() {
        mainScreen.scrollViews.element(boundBy: 0).tap()
        XCTAssertEqual(mainScreen.scrollViews.count, 5)
        XCTAssert(!mainScreen.undo.isEnabled)
        
        mainScreen.delete.tap()
        
        XCTAssertEqual(mainScreen.scrollViews.count, 4)
        XCTAssert(mainScreen.undo.isEnabled)
    }
    
}
