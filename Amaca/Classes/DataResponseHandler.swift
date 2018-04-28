//
//  DataResponseHandler.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public struct DataResponseHandler: ResponseHandler {
    public typealias DataType = Data
    public let status: StatusCode
    public let response: HTTPURLResponse?
    public let error: Error?
    public let data: DataType?

    public init(data: Data?, response: URLResponse?, error: Error?) {
        self.error = error
        self.response = response as? HTTPURLResponse
        self.data = data
        if self.error == nil {
            self.status = StatusCode(rawValue: self.response?.statusCode ?? 0)
        } else {
            self.status = .error
        }
    }
}
