//
//  HeaderAuthenticationTest.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class HeaderAuthenticationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testApply() {
        let url = URL(string: "https://example.com/")!
        let auth = HeaderAuthentication(token: "secret123")
        var req = URLRequest(url: url)
        req = auth.applyTo(request: req)
        let result = req.value(forHTTPHeaderField: "Authorization")!
        XCTAssertEqual(result, "Bearer secret123")
    }
}
