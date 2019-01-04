//
//  CodableResponseHandler.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public struct CodableResponseHandler<T>:ResponseHandler where T: Codable {
    public typealias DataType = T
    public var status: StatusCode = .unkown
    public var response: HTTPURLResponse?
    public var error: Error?
    public var data: DataType?

    let decoder: JSONDecoder

    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    public init(data: Data?, response: URLResponse?, error: Error?) {
        self.decoder = JSONDecoder()
        self.parse(data: data, response: response, error: error)
    }

    mutating func parse(data: Data?, response: URLResponse?, error: Error?) {
        guard let unwrapedResponse = response as? HTTPURLResponse else {
            self.status = .unkown
            return
        }
        self.response = unwrapedResponse
        if error != nil {
            self.error = error
            self.status = .error
            return
        }
        self.status = StatusCode(rawValue: unwrapedResponse.statusCode)
        if unwrapedResponse.statusCode == 204 { return }
        do {
            if let unwrappedData = data {
                self.data = try decoder.decode(T.self, from: unwrappedData)
            }
        } catch let err {
            self.error = err
            self.status = .parserError
        }
    }
}
