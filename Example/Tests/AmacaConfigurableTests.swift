//
//  AmacaConfigurableTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

struct MockConfig: AmacaConfigurable {
    var session: URLSession
    var baseUrl: URL
}

class AmacaConfigurableTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testComponents() {
        let url = URL(string: "https://example.com/api/v1")!
        let config = MockConfig(session: URLSession.shared, baseUrl: url)
        let comps = config.urlComponents()
        XCTAssertEqual(comps.scheme, "https")
        XCTAssertEqual(comps.host, "example.com")
        XCTAssertEqual(comps.path, "/api/v1")
    }
}
