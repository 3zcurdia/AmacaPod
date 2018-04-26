//
//  DataClientTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca
import DVR

class DataServiceTests: XCTestCase {
    let url = URL(string: "https://jsonplaceholder.typicode.com")!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func buildService(for session: URLSession) -> DataService {
        let config = MockConfig(session: session, baseUrl: url)
        return DataService(config: config, path: "/posts", auth: nil)
    }

    func testIndexSuccess() {
        let session = Session(cassetteName: "index.success")
        let service = buildService(for: session)
        let exp = expectation(description: "Successfull index")
        service.index { response in
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
        let session = Session(cassetteName: "show.success")
        let service = buildService(for: session)
        let exp = expectation(description: "Successfull show")
        service.show(1) { response in
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
        let session = Session(cassetteName: "create.success")
        let service = buildService(for: session)
        let exp = expectation(description: "Successfull create")
        let data = try? JSONEncoder().encode(MockCodablePost(title: "title", body: "body"))
        service.create(data: data!) { response in
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
        let session = Session(cassetteName: "update.success")
        let service = buildService(for: session)
        let exp = expectation(description: "Successfull update")
        let data = try? JSONEncoder().encode(MockCodablePost(title: "title", body: "body"))
        service.update(101, data: data!) { response in
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
        let session = Session(cassetteName: "delete.success")
        let service = buildService(for: session)
        let exp = expectation(description: "Successfull delete")
        service.delete(102) { response in
            exp.fulfill()
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            XCTAssertNotNil(response.response)
            XCTAssertEqual(response.status, StatusCode.success)
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}
