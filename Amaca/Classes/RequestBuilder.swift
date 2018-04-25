//
//  RequestBuilder.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class RequestBuilder {
    let componets: URLComponents
    let auth: Authenticable?
    public var contentType: String

    public init(components: URLComponents, auth: Authenticable?, contentType: String = "application/json") {
        self.componets = components
        self.auth = auth
        self.contentType = contentType
    }

    public func get(path: String, params: [String: String]? = nil) -> URLRequest {
        return build("GET", path: path, params: params)
    }

    public func post(path: String, params: [String: String]? = nil) -> URLRequest {
        return build("POST", path: path, params: params)
    }

    public func put(path: String, params: [String: String]? = nil) -> URLRequest {
        return build("PUT", path: path, params: params)
    }

    public func patch(path: String, params: [String: String]? = nil) -> URLRequest {
        return build("PATCH", path: path, params: params)
    }

    public func delete(path: String, params: [String: String]? = nil) -> URLRequest {
        return build("DELETE", path: path, params: params)
    }

    public func build(_ action: String, path: String, params: [String: String]? = nil) -> URLRequest {
        var comp = self.componets
        comp.path = "\(comp.path)\(path)"
        comp = setQueryFor(comp, params: params)

        var req = URLRequest(url: comp.url!)
        req.httpMethod = action
        req.setValue(self.contentType, forHTTPHeaderField: "Content-Type")
        if let auth = self.auth {
            req = auth.applyTo(request: req)
        }

        return req
    }

    private func setQueryFor(_ urlComponents: URLComponents, params: [String: String]?) -> URLComponents {
        guard let rawParams = params, !rawParams.isEmpty else { return urlComponents }
        var comp = urlComponents
        var queryItems = comp.queryItems ?? [URLQueryItem]()
        for (key, value) in rawParams {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        if !queryItems.isEmpty {
            comp.queryItems = queryItems
        }
        return comp
    }
}
