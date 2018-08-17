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
        
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        let albumsToolbar = app.toolbars["Albums toolbar"]
        let undo = albumsToolbar.buttons["Undo"]
        while undo.isEnabled {
            undo.tap()
        }
    }
    
    func testDeleteAlbum() {
        let scroller = app.otherElements["Albums scroller"]
        let scrollViews = scroller.scrollViews.otherElements
        let albumsToolbar = app.toolbars["Albums toolbar"]
        let delete = albumsToolbar.buttons["Delete"]
        let undo = albumsToolbar.buttons["Undo"]
        
        scrollViews.element(boundBy: 0).tap()
        XCTAssertEqual(scrollViews.count, 4)
        XCTAssert(!undo.isEnabled)
        
        delete.tap()
        
        XCTAssertEqual(scrollViews.count, 3)
        XCTAssert(undo.isEnabled)
    }
    
}
