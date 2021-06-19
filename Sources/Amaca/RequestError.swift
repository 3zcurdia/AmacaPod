//
//  RequestError.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

public enum RequestError: Error, Titleable {
    case invalidRequest

    public var title: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        }
    }
}
