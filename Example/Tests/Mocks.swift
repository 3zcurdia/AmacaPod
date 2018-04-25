//
//  Mocks.swift
//  Amaca_Tests
//
//  Created by Luis Ezcurdia on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Amaca

class MockError: LocalizedError {}

struct MockConfig: AmacaConfigurable {
    var session: URLSession
    var baseUrl: URL
}

struct MockDecodablePost: Codable {
    let id: Int
    let title: String
    let content: String
}
