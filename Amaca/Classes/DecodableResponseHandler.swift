//
//  DecodableResponseHandler.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public struct DecodableResponseHandler<T>:ResponseHandler where T: Decodable {
    public typealias DataType = T
    public var status: StatusCode = .unkown
    public var response: HTTPURLResponse?
    public var error: Error?
    public var data: DataType?

    public var decoder = JSONDecoder()

    public init() {}

    public init(data: Data?, response: URLResponse?, error: Error?) {
        parse(data: data, response: response, error: error)
    }

    mutating func parse(data: Data?, response: URLResponse?, error: Error?) {
        self.response = response as? HTTPURLResponse
        if error != nil {
            self.error = error
            self.status = .error
            self.data = nil
            return
        }
        var json: T? = nil
        var status = StatusCode(rawValue: self.response?.statusCode ?? 0)
        do {
            if let unwrappedData = data {
                json = try decoder.decode(T.self, from: unwrappedData)
            }
            self.error = nil
        } catch let err {
            if self.response?.statusCode == 204 {
                self.error = nil
            } else {
                self.error = err
                status = .parserError
            }
        }
        self.data = json
        self.status = status
    }
}
