//
//  CacheManagerTest.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 5/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class CacheManagerTest: XCTestCase {
    let manager = CacheManager<MockCodablePost>()

    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")
    let rawJson = """
        {
          "userId": 1,
          "id": 1,
          "title": "sunt aut facere repellat provident occaecati",
          "body": "quia et suscipit suscipit recusandae consequuntur expedita"
        }
    """.data(using: .utf8)!

    lazy var jsonDecoded: MockCodablePost? = {
        do {
            return try JSONDecoder().decode(MockCodablePost.self, from: self.rawJson)
        } catch let err {
            XCTFail("PARSING ERROR: \(err)")
            return nil
        }
    }()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        manager.purge()
        super.tearDown()
    }

    func testInit() {
        XCTAssertEqual([String: String](), manager.manifest)
        XCTAssertTrue(FileManager.default.fileExists(atPath: StorageType.cache.folder.path))
    }

    func testSave() {
        if let sha = manager.save(url: url, rawData: rawJson, jsonData: jsonDecoded!) {
            XCTAssertEqual("3dc8195ca5f21ea1bbac19c57523a1376290656e27bc3758663f762232891169", sha)
        } else {
            XCTFail("Could not save data")
        }
        XCTAssertNil(manager.save(url: nil, rawData: rawJson, jsonData: jsonDecoded!))
        XCTAssertNil(manager.save(url: url, rawData: nil, jsonData: jsonDecoded!))
    }

    func testfind() {
        if let _ = manager.save(url: url, rawData: rawJson, jsonData: jsonDecoded!) {
            if let post = manager.find(url: url) {
                XCTAssertEqual("sunt aut facere repellat provident occaecati", post.title)
                XCTAssertEqual("quia et suscipit suscipit recusandae consequuntur expedita", post.body)
            } else {
                XCTFail("Could not find post")
            }
        } else {
            XCTFail("Could not save data")
        }
        XCTAssertNil(manager.find(url: URL(string: "https://jsonplaceholder.typicode.com/posts/2")!))
        XCTAssertNil(manager.find(url: nil))
    }

    func testLoadManifest() {
        XCTAssertTrue(manager.manifest.isEmpty)
        if let sha = manager.save(url: url, rawData: rawJson, jsonData: jsonDecoded!) {
            XCTAssertFalse(manager.manifest.isEmpty)
            XCTAssertEqual(1, manager.manifest.count)
            XCTAssertEqual(sha, manager.manifest[url!.absoluteString])
        } else {
            XCTFail("Could not save data")
        }
    }
}
