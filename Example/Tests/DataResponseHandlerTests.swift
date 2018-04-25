//
//  DataResponseHandlerTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class DataResponseHandlerTests: XCTestCase {
    let url = URL(string: "https://example.com/api")!
    let data = "".data(using: .utf8)

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNilValuesResponseHandler() {
        let handler = DataResponseHandler(data: nil, response: nil, error: nil)
        XCTAssertNil(handler.error)
        XCTAssertNil(handler.data)
        XCTAssertNil(handler.response)
        XCTAssertEqual(handler.status, StatusCode.unkown)
    }

    func testNilResponseHandler() {
        let handler = DataResponseHandler(data: data, response: nil, error: nil)
        XCTAssertNil(handler.error)
        XCTAssertNil(handler.response)
        XCTAssertEqual(handler.data, data)
        XCTAssertEqual(handler.status, StatusCode.unkown)
    }

    func testUknownResponseHandler() {
        let response = HTTPURLResponse(url: url, statusCode: 0,
                                       httpVersion: nil, headerFields: nil)
        let handler = DataResponseHandler(data: data, response: response, error: nil)
        XCTAssertNil(handler.error)
        XCTAssertEqual(handler.response, response)
        XCTAssertEqual(handler.data, data)
        XCTAssertEqual(handler.status, StatusCode.unkown)
    }

    func testErrorHandler() {
        let response = HTTPURLResponse(url: url, statusCode: 900,
                                       httpVersion: nil, headerFields: nil)
        let error = MockError()
        let handler = DataResponseHandler(data: data, response: response, error: error)
        XCTAssertNotNil(handler.error)
        XCTAssertEqual(handler.response, response)
        XCTAssertEqual(handler.data, data)
        XCTAssertEqual(handler.status, StatusCode.error)
    }

    func testSuccessHandler() {
        let response = HTTPURLResponse(url: url, statusCode: 200,
                                       httpVersion: nil, headerFields: nil)
        let handler = DataResponseHandler(data: data, response: response, error: nil)
        XCTAssertNil(handler.error)
        XCTAssertEqual(handler.response, response)
        XCTAssertEqual(handler.data, data)
        XCTAssertEqual(handler.status, StatusCode.success)
    }

}
