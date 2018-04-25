//
//  RequestBuilderTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class RequestBuilderTests: XCTestCase {
    let components = URLComponents(string: "https://example.com/api")!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHttpMethods() {
        let builder = RequestBuilder(components: components, auth: nil)
        XCTAssertEqual(builder.get(path: "/foo").httpMethod, "GET")
        XCTAssertEqual(builder.post(path: "/foo").httpMethod, "POST")
        XCTAssertEqual(builder.put(path: "/foo").httpMethod, "PUT")
        XCTAssertEqual(builder.patch(path: "/foo").httpMethod, "PATCH")
        XCTAssertEqual(builder.delete(path: "/foo").httpMethod, "DELETE")
    }

    func testBuildUrl() {
        let builder = RequestBuilder(components: components, auth: nil)
        let req = builder.get(path: "/foo")
        XCTAssertEqual(req.url!.absoluteString, "https://example.com/api/foo")
    }
}
