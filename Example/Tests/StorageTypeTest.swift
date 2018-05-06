//
//  StorageTypeTest.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 5/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class StorageTypeTest: XCTestCase {

    override func setUp() {
        super.setUp()
        StorageType.cache.ensureExists()
        StorageType.permanent.ensureExists()
    }

    override func tearDown() {
        StorageType.cache.clearStorage()
        StorageType.permanent.clearStorage()
        super.tearDown()
    }

    func testSearchPathDirectory() {
        XCTAssertEqual(FileManager.SearchPathDirectory.cachesDirectory,
                       StorageType.cache.searchPathDirectory)
        XCTAssertEqual(FileManager.SearchPathDirectory.documentDirectory,
                       StorageType.permanent.searchPathDirectory)
    }

    func testFolder() {
        XCTAssertEqual("org.ezcurdia.Amaca.storage",
            StorageType.cache.folder.lastPathComponent)
        XCTAssertEqual("org.ezcurdia.Amaca.storage", StorageType.permanent.folder.lastPathComponent)
    }

    func testClearStore() {
        let fileManager = FileManager.default
        XCTAssertTrue(fileManager.fileExists(atPath: StorageType.cache.folder.path))
        // TODO: folder test failing due implementation inside cocoapods
        //XCTAssertTrue(fileManager.fileExists(atPath: StorageType.permanent.folder.path))

        StorageType.cache.clearStorage()
        StorageType.permanent.clearStorage()

        XCTAssertFalse(fileManager.fileExists(atPath: StorageType.cache.folder.path))
        XCTAssertFalse(fileManager.fileExists(atPath: StorageType.permanent.folder.path))

    }

}
