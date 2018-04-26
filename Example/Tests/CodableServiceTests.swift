//
//  CodableClientTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca
import DVR

class CodableServiceTests: XCTestCase {
    let url = URL(string: "https://jsonplaceholder.typicode.com")!
    var service: CodableService<MockCodablePost>!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func buildService(for session: URLSession) -> CodableService<MockCodablePost> {
        let config = MockConfig(session: session, baseUrl: url)
        return CodableService<MockCodablePost>(config: config, path: "/posts", auth: nil)
    }

    func testIndexSuccess() {
        let session = Session(cassetteName: "index.success")
        let service = buildService(for: session)
        let exp = expectation(description: "Successfull index")
        service.index { response in
            exp.fulfill()
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            XCTAssertEqual(response.data!.count, 100)
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
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.data)
            XCTAssertEqual(response.data!.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
            XCTAssertEqual(response.data!.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
            XCTAssertNotNil(response.response)
            XCTAssertEqual(response.status, StatusCode.success)
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testCreateSuccess() {
        let session = Session(cassetteName: "create.success")
        let service = buildService(for: session)
        let exp = expectation(description: "Successfull create")
        let post = MockCodablePost(title: "title", body: "body")
        service.create(data: post) { response in
            exp.fulfill()
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
        let post = MockCodablePost(title: "title", body: "body")
        service.update(101, data: post) { response in
            exp.fulfill()
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
            XCTAssertNil(response.data)
            XCTAssertNotNil(response.response)
            XCTAssertEqual(response.status, StatusCode.success)
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}
