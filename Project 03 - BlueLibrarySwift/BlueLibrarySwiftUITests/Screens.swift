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
    
    var scroller: XCUIElement { return app.otherElements["Albums scroller"] }
    var scrollViews: XCUIElementQuery { return scroller.scrollViews.otherElements }
    var albumsToolbar: XCUIElement { return app.toolbars["Albums toolbar"] }
    var albumInfo: XCUIElement { return app.tables["Albums information"] }
    var delete: XCUIElement { return albumsToolbar.buttons["Delete"] }
    var undo: XCUIElement { return albumsToolbar.buttons["Undo"] }
    var tableTextElements: [XCUIElement] { return albumInfo.cells.allElementsBoundByAccessibilityElement }
    
    func albumWithIndex(index: Int) -> XCUIElement {
        let element = scrollViews.element(boundBy: index)
        return element
    }
    
    func selectAlbumWithIndex(index: Int) -> Void {
        let element = albumWithIndex(index: index)
        let exists = element.waitForExistence(timeout: defaultTimeout)
        XCTAssert(exists)
        element.tap()
    }
    
    func tableTexts() -> [(title: String, value: String)]{
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
