//
//  ResponseHandler.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public protocol ResponseHandler {
    associatedtype DataType
    var status: StatusCode { get }
    var response: HTTPURLResponse? { get }
    var error: Error? { get }
    var data: DataType? { get }
}
