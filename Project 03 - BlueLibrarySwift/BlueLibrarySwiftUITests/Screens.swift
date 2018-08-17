//
//  Screen.swift
//  BlueLibrarySwiftUITests
//
//  Created by Igor Balagurov on 18/08/2018.
//  Copyright © 2018 Raywenderlich. All rights reserved.
//

import XCTest

class MainScreen {
    var app = XCUIApplication()
    
    var scroller: XCUIElement { return app.otherElements["Albums scroller"] }
    var scrollViews: XCUIElementQuery { return scroller.scrollViews.otherElements }
    var albumsToolbar: XCUIElement { return app.toolbars["Albums toolbar"] }
    var delete: XCUIElement { return albumsToolbar.buttons["Delete"] }
    var undo: XCUIElement { return albumsToolbar.buttons["Undo"] }
}
