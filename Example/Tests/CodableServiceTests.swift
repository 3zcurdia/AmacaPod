//
//  CodableClientTests.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Amaca

class CodableServiceTests: XCTestCase {
    let url = URL(string: "https://jsonplaceholder.typicode.com")!
    var service: CodableService<MockCodablePost>!

    override func setUp() {
        super.setUp()
        let session = URLSession.shared
        let config = MockConfig(session: session, baseUrl: url)
        self.service = CodableService<MockCodablePost>(config: config, path: "/posts", auth: nil)
    }

    override func tearDown() {
        super.tearDown()
    }

//    func testIndexSuccess() {
//        let exp = expectation(description: "Successfull codable index")
//        self.service.index { response in
//            exp.fulfill()
//            XCTAssertEqual(response.status, StatusCode.success)
//        }
//        self.service.index { response in
//            exp.fulfill()
//            XCTAssertNil(response.error)
//            XCTAssertNotNil(response.data)
//            XCTAssertNotNil(response.response)
//            XCTAssertEqual(response.status, StatusCode.success)
//        }
//
//        waitForExpectations(timeout: 2, handler: nil)
//    }
//
//    func testShowSuccess() {
//        let exp = expectation(description: "Successfull show")
//        self.client.show(id: 1) { resp in
//            exp.fulfill()
//            let response = resp as! DataResponseHandler
//            XCTAssertNotNil(response)
//            XCTAssertNil(response.error)
//            XCTAssertNotNil(response.data)
//            XCTAssertNotNil(response.response)
//            XCTAssertEqual(response.status, StatusCode.success)
//        }
//
//        waitForExpectations(timeout: 2, handler: nil)
//    }
//
//    func testCreateSuccess() {
//        let exp = expectation(description: "Successfull create")
//        self.client.create(data: "{}".data(using: .utf8)!) { resp in
//            exp.fulfill()
//            let response = resp as! DataResponseHandler
//            XCTAssertNotNil(response)
//            XCTAssertNil(response.error)
//            XCTAssertNotNil(response.data)
//            XCTAssertNotNil(response.response)
//            XCTAssertEqual(response.status, StatusCode.success)
//        }
//
//        waitForExpectations(timeout: 2, handler: nil)
//    }
//
//
//    func testUpdateSuccess() {
//        let exp = expectation(description: "Successfull update")
//        self.client.update(id: 1, data: "{}".data(using: .utf8)!) { resp in
//            exp.fulfill()
//            let response = resp as! DataResponseHandler
//            XCTAssertNotNil(response)
//            XCTAssertNil(response.error)
//            XCTAssertNotNil(response.data)
//            XCTAssertNotNil(response.response)
//            XCTAssertEqual(response.status, StatusCode.success)
//        }
//
//        waitForExpectations(timeout: 2, handler: nil)
//    }
}
