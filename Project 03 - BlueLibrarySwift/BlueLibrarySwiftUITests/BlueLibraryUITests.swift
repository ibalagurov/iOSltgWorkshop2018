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
        
        // UI tests spend a lot of time on animations
        UIView.setAnimationsEnabled(false)
        
        app.launch()
        
        // portrait orientation is default
        XCUIDevice.shared.orientation = .portrait
    }
    
    override func tearDown() {
        super.tearDown()
        while mainScreen.undo.isEnabled {
            mainScreen.undo.tap()
        }
    }
    
    func testDeleteAlbum() {
        XCTAssertEqual(mainScreen.scrollViews.count, 5)
        XCTAssert(!mainScreen.undo.isEnabled)
        
        mainScreen.delete.tap()
        
        XCTAssertEqual(mainScreen.scrollViews.count, 4)
        XCTAssert(mainScreen.undo.isEnabled)
    }
    
    func testDeleteAllAlbums() {
        XCTAssertEqual(mainScreen.scrollViews.count, 5)
        
        for _ in 1...5 { mainScreen.delete.tap() }
        
        XCTAssertEqual(mainScreen.scrollViews.count, 0)
        XCTAssert(mainScreen.undo.isEnabled)
        XCTAssert(!mainScreen.delete.isEnabled)
    }
    
    func testUndoAlbumDeletion() {
        mainScreen.delete.tap()
        XCTAssertEqual(mainScreen.scrollViews.count, 4)
        
        mainScreen.undo.tap()
        
        XCTAssertEqual(mainScreen.scrollViews.count, 5)
        XCTAssert(!mainScreen.undo.isEnabled)
    }
    
    func testSwipeAlbumView() {
        mainScreen.scroller.swipeRight()
        XCTAssert(mainScreen.scrollViews.element(boundBy: 0).isHittable)
        XCTAssert(!mainScreen.scrollViews.element(boundBy: 4).isHittable)
        
        mainScreen.scroller.swipeLeft()
        
        XCTAssert(!mainScreen.scrollViews.element(boundBy: 0).isHittable)
        XCTAssert(mainScreen.scrollViews.element(boundBy: 4).isHittable)
    }
    
    func testLandscapeOrientation() {
        mainScreen.scroller.swipeRight()
        XCTAssert(mainScreen.scrollViews.element(boundBy: 0).isHittable)
        XCTAssert(!mainScreen.scrollViews.element(boundBy: 4).isHittable)
        
        XCUIDevice.shared.orientation = .landscapeRight
        
        XCTAssert(mainScreen.scrollViews.element(boundBy: 0).isHittable)
        XCTAssert(mainScreen.scrollViews.element(boundBy: 4).isHittable)
    }
    
    func testAlbumSelection() {
        mainScreen.scrollViews.element(boundBy: 0).tap()
        let tableTextElements = mainScreen.app.tables.cells.staticTexts.allElementsBoundByAccessibilityElement
        let texts = tableTextElements.map({ $0.label })
        print(texts)
    }
}
