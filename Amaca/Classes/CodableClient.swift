//
//  CodableClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

class CodableClient<T>: DataClient where T: Codable {
    func create(data: T, completionHandler: @escaping responseHandlerClojure) {
        var request = requestBuilder.post(path: self.path)
        request.httpBody = try? JSONEncoder().encode(data)
        let task = buildTaksFor(request: request, completionHandler: completionHandler)
        task.resume()
    }

    func update(id: Int, data: T, completionHandler: @escaping responseHandlerClojure) {
        self.delete(slug: String(describing: id), completionHandler: completionHandler)
    }

    func update(slug: String, data: T, completionHandler: @escaping responseHandlerClojure) {
        var request = requestBuilder.patch(path: "\(self.path)/\(slug)")
        request.httpBody = try? JSONEncoder().encode(data)
        let task = buildTaksFor(request: request, completionHandler: completionHandler)
        task.resume()
    }

    override func buildResponse(data: Data?, response: URLResponse?, error: Error?) -> ResponseHandler {
        return DecodableResponseHandler<T>(data: data, response: response, error: error)
    }
}
