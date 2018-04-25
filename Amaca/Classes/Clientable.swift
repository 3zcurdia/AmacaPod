//
//  Clientable.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

typealias responseHandlerClojure = (ResponseHandler) -> Void

protocol Clientable {
    var config: AmacaConfigurable { get }
    var path: String { get }
    var requestBuilder: RequestBuilder { get }

    func index(_ completionHandler: @escaping responseHandlerClojure)

    func show(id: Int, completionHandler: @escaping responseHandlerClojure)
    func show(slug: String, completionHandler: @escaping responseHandlerClojure)

    func create(data: Data, completionHandler: @escaping responseHandlerClojure)

    func update(id: Int, data: Data, completionHandler: @escaping responseHandlerClojure)
    func update(slug: String, data: Data, completionHandler: @escaping responseHandlerClojure)

    func delete(id: Int, completionHandler: @escaping responseHandlerClojure)
    func delete(slug: String, completionHandler: @escaping responseHandlerClojure)

    func buildResponse(data: Data?, response: URLResponse?, error: Error?) -> ResponseHandler
}
