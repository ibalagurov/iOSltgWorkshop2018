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
        XCTContext.runActivity(named: "Launch the application") {
            _ in app.launch()
            // portrait orientation is default
            XCUIDevice.shared.orientation = .portrait
        }
    }
    
    override func tearDown() {
        super.tearDown()
        XCTContext.runActivity(named: "Drop state and close application") { _ in
            while mainScreen.undo.isEnabled {
                mainScreen.undo.tap()
            }
            app.terminate()
        }
    }
    
    func testDeleteAlbum() {
        XCTContext.runActivity(named: "There are 5 albums and undo button is disabled") { _ in
            XCTAssertEqual(mainScreen.scrollViews.count, 5)
            XCTAssert(!mainScreen.undo.isEnabled)
        }
        
        XCTContext.runActivity(named: "Delete selected album") { _ in
            mainScreen.delete.tap()
        }
        
        XCTContext.runActivity(named: "There are should be 4 albums and undo button should be enabled") { _ in
            XCTAssertEqual(mainScreen.scrollViews.count, 4)
            XCTAssert(mainScreen.undo.isEnabled)
        }
    }
    
    func testDeleteAllAlbums() {
        XCTContext.runActivity(named: "There are 5 albums") { _ in
            XCTAssertEqual(mainScreen.scrollViews.count, 5)
        }
        
        XCTContext.runActivity(named: "Delete all albums") { _ in
            for _ in 1...5 { mainScreen.delete.tap() }
        }
        
        XCTContext.runActivity(named: "Shouldn't be any albums, undo button is enabled and delete button is disabled") { _ in
            XCTAssertEqual(mainScreen.scrollViews.count, 0)
            XCTAssert(mainScreen.undo.isEnabled)
            XCTAssert(!mainScreen.delete.isEnabled)
        }
    }
    
    func testUndoAlbumDeletion() {
        XCTContext.runActivity(named: "There are 4 albums and one was deleted") { _ in
            mainScreen.delete.tap()
            XCTAssertEqual(mainScreen.scrollViews.count, 4)
        }
        
        XCTContext.runActivity(named: "Undo deletion") { _ in
            mainScreen.undo.tap()
        }
        
        XCTContext.runActivity(named: "Should be 5 albums and undo button is disabled") { _ in
            XCTAssertEqual(mainScreen.scrollViews.count, 5)
            XCTAssert(!mainScreen.undo.isEnabled)
        }
    }
    
    func testSwipeAlbumView() {
        XCTContext.runActivity(named: "There are 5 albums: first is visible, last isn't visible") { _ in
            mainScreen.scroller.swipeRight()
            XCTAssert(mainScreen.scrollViews.element(boundBy: 0).isHittable)
            XCTAssert(!mainScreen.scrollViews.element(boundBy: 4).isHittable)
        }
        
        XCTContext.runActivity(named: "Scroll albums to the end of the list") { _ in
            mainScreen.scroller.swipeLeft()
        }
        
        XCTContext.runActivity(named: "First album shouldn't be visible, the last one last is visible") { _ in
            XCTAssert(!mainScreen.scrollViews.element(boundBy: 0).isHittable)
            XCTAssert(mainScreen.scrollViews.element(boundBy: 4).isHittable)
        }
    }
    
    func testLandscapeOrientation() {
        XCTContext.runActivity(named: "There are 5 albums: first is visible, last isn't visible") { _ in
            mainScreen.scroller.swipeRight()
            XCTAssert(mainScreen.scrollViews.element(boundBy: 0).isHittable)
            XCTAssert(!mainScreen.scrollViews.element(boundBy: 4).isHittable)
        }
        
        XCTContext.runActivity(named: "Change device orientation to landscape") { _ in
            XCUIDevice.shared.orientation = .landscapeRight
        }
        
        XCTContext.runActivity(named: "First and last albums should be visible") { _ in
            XCTAssert(mainScreen.scrollViews.element(boundBy: 0).isHittable)
            XCTAssert(mainScreen.scrollViews.element(boundBy: 4).isHittable)
        }
    }
    
    func testAlbumSelection() {
        XCTContext.runActivity(named: "Select 'Lady Gaga' album") { _ in
            mainScreen.selectAlbumWithIndex(index: 1)
        }
        
        XCTContext.runActivity(named: "Album should be 'Poker Face'") { _ in
            let album = mainScreen.rowValueByTitle(title: "Album")
            XCTAssertEqual(album, "Poker Face")
        }
        
        XCTContext.runActivity(named: "Select 'U2' album") { _ in
            mainScreen.selectAlbumWithIndex(index: 3)
        }
        
        XCTContext.runActivity(named: "Album should be 'Staring at the Sun'") { _ in
            let album = mainScreen.rowValueByTitle(title: "Album")
            XCTAssertEqual(album, "Staring at the Sun")
        }
    }
    
    func testAlbumInformation() {
        XCTContext.runActivity(named: "Select 'Linked Park' album") { _ in
            mainScreen.selectAlbumWithIndex(index: 4)
        }
        
        XCTContext.runActivity(named: "Check all album information fields") { _ in
            let tableRows = mainScreen.tableTexts()
            let expectedRows = ["Album": "Iridescent", "Artist": "Linkin Park", "Year": "2000", "Genre": "Pop"]
            for (title, value) in tableRows {
                XCTAssertEqual(expectedRows[title], value)
            }
        }
        
    }
}
