//
//  Clientable.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

protocol Clientable {
    var config: AmacaConfigurable { get }
    var path: String { get }
    var requestBuilder: RequestBuilder { get }
}
