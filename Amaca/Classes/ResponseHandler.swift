//
//  ResponseHandler.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

protocol ResponseHandler {
    var status: StatusCode { get }
    var response: HTTPURLResponse? { get }
    var error: Error? { get }
}
