//
//  Authenticable.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/24/18.
//

import Foundation

public protocol Authenticable {
    var token: String { get }
    func applyTo(request: URLRequest) -> URLRequest
}

public struct QueryAuthentication: Authenticable {
    public let token: String
    public var tokenKey: String = "token"

    public init(token: String) {
        self.token = token
    }

    public func applyTo(request: URLRequest) -> URLRequest {
        guard let url = request.url else { return request }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return request
        }
        var req: URLRequest = request
        var items = components.queryItems ?? [URLQueryItem]()
        items.append(URLQueryItem(name: self.tokenKey, value: token))
        components.queryItems = items
        req.url = components.url
        return req
    }

}

public struct HeaderAuthentication: Authenticable {
    public let token: String
    public var headerKey = "Bearer"

    public init(token: String) {
        self.token = token
    }

    public func applyTo(request: URLRequest) -> URLRequest {
        var req: URLRequest = request
        req.addValue("\(headerKey) \(token)", forHTTPHeaderField: "Authorization")
        return req
    }
}
