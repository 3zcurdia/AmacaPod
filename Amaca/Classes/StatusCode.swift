//
//  StatusCode.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/24/18.
//

import Foundation

public enum StatusCode: Int {
    case unkown = 0
    case info        // 1xx
    case success     // 2xx
    case redirection // 3xx
    case clientError // 4xx
    case serverError // 5xx
    case error   = 10000
    case parserError

    public init(rawValue: Int) {
        switch rawValue {
        case 100, 101, 102:
            self = .info
        case 200, 201, 202, 203, 204, 205, 206, 207, 208, 226:
            self = .success
        case 300, 301, 302, 303, 304, 305, 306, 307, 308:
            self = .redirection
        case 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412,
          413, 414, 415, 416, 417, 418, 421, 422, 423, 424, 426, 428, 429, 431, 451:
            self = .clientError
        case 500, 501, 502, 503, 504, 505, 506, 507, 510, 511:
            self = .serverError
        case 512..<10001:
            self = .error
        case 10001:
            self = .parserError
        default:
            self = .unkown
        }
    }
}
