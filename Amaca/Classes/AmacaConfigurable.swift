//
//  AmacaConfigurable.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public protocol AmacaConfigurable {
    var session: URLSession { get }
    var baseUrl: URL { get }
}

extension AmacaConfigurable {
    public func urlComponents() -> URLComponents {
        return URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
    }
}
