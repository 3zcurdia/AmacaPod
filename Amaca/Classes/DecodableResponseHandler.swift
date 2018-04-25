//
//  DecodableResponseHandler.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public struct DecodableResponseHandler<T>:ResponseHandler where T: Decodable {
    public let status: StatusCode
    public let response: HTTPURLResponse?
    public let error: Error?
    public let data: T?

    public init(data: Data?, response: URLResponse?, error: Error?) {
        self.response = response as? HTTPURLResponse
        if error != nil {
            self.error = error
            self.status = .error
            self.data = nil
            return
        }
        var json: T? = nil
        do {
            if let unwrappedData = data {
                json = try JSONDecoder().decode(T.self, from: unwrappedData)
            }
            self.status = StatusCode(rawValue: self.response?.statusCode ?? 0)
            self.error = nil
        } catch let err {
            self.error = err
            self.status = .parserError
        }
        self.data = json
    }
}
