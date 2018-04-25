//
//  StatusCodeTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class StatusCodeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInfo() {
        for status in [100, 101, 102] {
            XCTAssertEqual(StatusCode.info, StatusCode(rawValue: status))
        }
    }

    func testSuccess() {
        for status in [200, 201, 202, 203, 204, 205, 206, 207, 208, 226] {
            XCTAssertEqual(StatusCode.success, StatusCode(rawValue: status))
        }
    }

    func testRedirection() {
        for status in [300, 301, 302, 303, 304, 305, 306, 307, 308] {
            XCTAssertEqual(StatusCode.redirection, StatusCode(rawValue: status))
        }
    }

    func testClientError() {
        for status in [400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410,
                       411, 412, 413, 414, 415, 416, 417, 418, 421, 422, 423,
                       424, 426, 428, 429, 431, 451] {
            XCTAssertEqual(StatusCode.clientError, StatusCode(rawValue: status))
        }
    }

    func testSeverError() {
        for status in [500, 501, 502, 503, 504, 505, 506, 507, 510, 511] {
            XCTAssertEqual(StatusCode.serverError, StatusCode(rawValue: status))
        }
    }

    func testMisc() {
        XCTAssertEqual(StatusCode.unkown, StatusCode(rawValue: 0))
        XCTAssertEqual(StatusCode.error, StatusCode(rawValue: 512))
        XCTAssertEqual(StatusCode.error, StatusCode(rawValue: 10000))
        XCTAssertEqual(StatusCode.parserError, StatusCode(rawValue: 10001))
    }
}
