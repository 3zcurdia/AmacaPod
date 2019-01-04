//
//  CodableResponseHandlerTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class CodableResponseHandlerTests: XCTestCase {
    let url = URL(string: "https://example.com/api")!
    let post = MockCodablePost(title: "foo", body: "bar baz")
    lazy var encodedData: Data = {
        return (try? JSONEncoder().encode(post)) ?? Data()
    }()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNilValuesResponseHandler() {
        let handler = CodableResponseHandler<MockCodablePost>(data: nil,
                                                                  response: nil,
                                                                  error: nil)
        XCTAssertNil(handler.error)
        XCTAssertNil(handler.data)
        XCTAssertNil(handler.response)
        XCTAssertEqual(handler.status, StatusCode.unkown)
    }

    func testNilResponseHandler() {
        let handler = CodableResponseHandler<MockCodablePost>(data: encodedData,
                                                                  response: nil,
                                                                  error: nil)
        XCTAssertNil(handler.error)
        XCTAssertNil(handler.response)
        XCTAssertNil(handler.data)
        XCTAssertEqual(handler.status, StatusCode.unkown)
    }

    func testUknownResponseHandler() {
        let response = HTTPURLResponse(url: url, statusCode: 0,
                                       httpVersion: nil, headerFields: nil)
        let handler = CodableResponseHandler<MockCodablePost>(data: encodedData,
                                                                  response: response,
                                                                  error: nil)
        XCTAssertNil(handler.error)
        XCTAssertEqual(handler.response, response)
        XCTAssertNotNil(handler.data)
        XCTAssertEqual(handler.status, StatusCode.unkown)
    }

    func testParserErrorHandler() {
        let response = HTTPURLResponse(url: url, statusCode: 200,
                                       httpVersion: nil, headerFields: nil)
        let data = "".data(using: .utf8)
        let handler = CodableResponseHandler<MockCodablePost>(data: data,
                                                                  response: response,
                                                                  error: nil)
        XCTAssertNotNil(handler.error)
        XCTAssertEqual(handler.response, response)
        XCTAssertNil(handler.data)
        XCTAssertEqual(handler.status, StatusCode.parserError)
    }

    func testErrorHandler() {
        let response = HTTPURLResponse(url: url, statusCode: 900,
                                       httpVersion: nil, headerFields: nil)
        let error = MockError()
        let handler = CodableResponseHandler<MockCodablePost>(data: encodedData,
                                                                  response: response,
                                                                  error: error)
        XCTAssertNotNil(handler.error)
        XCTAssertEqual(handler.response, response)
        XCTAssertNil(handler.data)
        XCTAssertEqual(handler.status, StatusCode.error)
    }

    func testNoContentHandler() {
        let response = HTTPURLResponse(url: url, statusCode: 204,
                                       httpVersion: nil, headerFields: nil)
        let handler = CodableResponseHandler<MockCodablePost>(data: encodedData,
                                                              response: response,
                                                              error: nil)
        XCTAssertNil(handler.error)
        XCTAssertEqual(handler.response, response)
        XCTAssertEqual(handler.status, StatusCode.success)
        XCTAssertNil(handler.data)
    }

    func testSuccessHandler() {
        let response = HTTPURLResponse(url: url, statusCode: 200,
                                       httpVersion: nil, headerFields: nil)
        let handler = CodableResponseHandler<MockCodablePost>(data: encodedData,
                                                                  response: response,
                                                                  error: nil)
        XCTAssertNil(handler.error)
        XCTAssertEqual(handler.response, response)
        XCTAssertEqual(handler.status, StatusCode.success)
        XCTAssertNotNil(handler.data)
        let result = handler.data!
        XCTAssertEqual(result.title, post.title)
        XCTAssertEqual(result.body, post.body)
    }

}
