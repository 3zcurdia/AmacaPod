//
//  RESTCodableClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class CodableService<T>: CodableClient<T> where T: Codable {
    public func index(cache: Bool = false, completionHandler: @escaping (DecodableResponseHandler<[T]>) -> Void) {
        let request = requestBuilder.get(path: self.path)
        listTaskFor(request: request, cache: cache, completionHandler: completionHandler)
    }

    public typealias CodableHandlerClojure = (DecodableResponseHandler<T>) -> Void
    public func show(_ remoteId: Int, cache: Bool = false,
                     completionHandler: @escaping CodableHandlerClojure) {
        self.show(slug: String(describing: remoteId), cache: cache, completionHandler: completionHandler)
    }

    public func show(slug: String, cache: Bool = false,
                     completionHandler: @escaping CodableHandlerClojure) {
        let request = requestBuilder.get(path: "\(self.path)/\(slug)")
        taskFor(request: request, cache: cache, completionHandler: completionHandler)
    }

    public func create(data: T,
                       completionHandler: @escaping CodableHandlerClojure) {
        var request = requestBuilder.post(path: self.path)
        request.httpBody = try? encoder.encode(data)
        taskFor(request: request, cache: false, completionHandler: completionHandler)
    }

     public func update(_ remoteId: Int, data: T,
                        completionHandler: @escaping CodableHandlerClojure) {
        self.update(slug: String(describing: remoteId), data: data, completionHandler: completionHandler)
    }

    public func update(slug: String, data: T,
                       completionHandler: @escaping CodableHandlerClojure) {
        var request = requestBuilder.put(path: "\(self.path)/\(slug)")
        request.httpBody = try? encoder.encode(data)
        taskFor(request: request, cache: false, completionHandler: completionHandler)
    }

    public func delete(_ remoteId: Int,
                       completionHandler: @escaping CodableHandlerClojure) {
        self.delete(slug: String(describing: remoteId), completionHandler: completionHandler)
    }

    public func delete(slug: String,
                       completionHandler: @escaping CodableHandlerClojure) {
        let request = requestBuilder.delete(path: "\(self.path)/\(slug)")
        taskFor(request: request, cache: false, completionHandler: completionHandler)
    }
}
