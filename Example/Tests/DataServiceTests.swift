//
//  DataClientTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class RESTDataClientTests: XCTestCase {
    let url = URL(string: "https://jsonplaceholder.typicode.com")!
    var service: DataService!

    override func setUp() {
        super.setUp()
        let session = URLSession.shared
        let config = MockConfig(session: session, baseUrl: url)
        self.service = DataService(config: config, path: "/posts", auth: nil)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testIndexSuccess() {
        let exp = expectation(description: "Successfull index")
        self.service.index { response in
            exp.fulfill()
            XCTAssertNotNil(response)
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            XCTAssertNotNil(response.response)
            XCTAssertEqual(response.status, StatusCode.success)
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testShowSuccess() {
        let exp = expectation(description: "Successfull show")
        self.service.show(1) { response in
            exp.fulfill()
            XCTAssertNotNil(response)
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            XCTAssertNotNil(response.response)
            XCTAssertEqual(response.status, StatusCode.success)
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testCreateSuccess() {
        let exp = expectation(description: "Successfull create")
        self.service.create(data: "{}".data(using: .utf8)!) { response in
            exp.fulfill()
            XCTAssertNotNil(response)
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            XCTAssertNotNil(response.response)
            XCTAssertEqual(response.status, StatusCode.success)
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testUpdateSuccess() {
        let exp = expectation(description: "Successfull update")
        self.service.update(1, data: "{}".data(using: .utf8)!) { response in
            exp.fulfill()
            XCTAssertNotNil(response)
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            XCTAssertNotNil(response.response)
            XCTAssertEqual(response.status, StatusCode.success)
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testDeleteSuccess() {
        let exp = expectation(description: "Successfull delete")
        self.service.delete(1) { response in
            exp.fulfill()
            XCTAssertNotNil(response)
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            XCTAssertNotNil(response.response)
            XCTAssertEqual(response.status, StatusCode.success)
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}
