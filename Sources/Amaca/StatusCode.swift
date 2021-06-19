//
//  StatusCode.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

enum StatusCode: Int {
    case unkown = 0
    case info
    case success
    case redirection
    case clientError
    case serverError

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
        default:
            self = .unkown
        }
    }

    func result() -> Result<Int?, Error> {
        switch self {
        case .success:
            return .success(self.rawValue)
        case .clientError:
            return .failure(ResponseError.clientError)
        case .serverError:
            return .failure(ResponseError.serverError)
        default:
            return .failure(ResponseError.invalidResponse)
        }
    }
}
