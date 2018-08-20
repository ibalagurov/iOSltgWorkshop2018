//
//  Screen.swift
//  BlueLibrarySwiftUITests
//
//  Created by Igor Balagurov on 18/08/2018.
//  Copyright © 2018 Raywenderlich. All rights reserved.
//

import XCTest

class MainScreen {
    let app = XCUIApplication()
    let defaultTimeout: TimeInterval = 10
    
    var scroller: XCUIElement { return app.otherElements["albums_scroller"] }
    var albumsList: XCUIElementQuery { return scroller.scrollViews.otherElements }
    var toolbar: XCUIElement { return app.toolbars["albums_toolbar"] }
    var albumInfo: XCUIElement { return app.tables["album_info"] }
    var delete: XCUIElement { return toolbar.buttons["Delete"] }
    var undo: XCUIElement { return toolbar.buttons["Undo"] }
    var tableTextElements: [XCUIElement] { return albumInfo.cells.allElementsBoundByAccessibilityElement }
    
    func albumWithIndex(index: Int) -> XCUIElement {
        let element = albumsList.element(boundBy: index)
        let exists = element.waitForExistence(timeout: defaultTimeout)
        XCTAssert(exists)
        return element
    }
    
    func selectAlbumWithIndex(index: Int) -> Void {
        let element = albumWithIndex(index: index)
        element.tap()
    }
    
    func tableTexts() -> [(title: String, value: String)]{
        let exists = albumInfo.waitForExistence(timeout: defaultTimeout)
        XCTAssert(exists)
        let cellTitleValue = tableTextElements.map({
            (title: $0.staticTexts["cell_title"].label, value: $0.staticTexts["cell_value"].label)
        })
        return cellTitleValue
    }
    
    func rowValueByTitle(title: String) -> String {
        let value = tableTexts().filter({$0.title == title})[0].value
        return value
    }
}
