//
//  RESTCodableClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class CodableService<T>: CodableClient<T> where T: Codable {
    public func index( completionHandler: @escaping (CodableResponseHandler<[T]>) -> Void) {
        let request = requestBuilder.get(path: self.path)
        taskForList(request: request, completionHandler: completionHandler)
    }

    public typealias CodableHandler = (CodableResponseHandler<T>) -> Void
    public func show(_ remoteId: Int,
                     completionHandler: @escaping CodableHandler) {
        self.show(slug: String(describing: remoteId), completionHandler: completionHandler)
    }

    public func show(slug: String,
                     completionHandler: @escaping CodableHandler) {
        let request = requestBuilder.get(path: "\(self.path)/\(slug)")
        taskForObject(request: request, completionHandler: completionHandler)
    }

    public func create(data: T,
                       completionHandler: @escaping CodableHandler) {
        var request = requestBuilder.post(path: self.path)
        request.httpBody = try? encoder.encode(data)
        taskForObject(request: request, completionHandler: completionHandler)
    }

     public func update(_ remoteId: Int, data: T,
                        completionHandler: @escaping CodableHandler) {
        self.update(slug: String(describing: remoteId), data: data, completionHandler: completionHandler)
    }

    public func update(slug: String, data: T,
                       completionHandler: @escaping CodableHandler) {
        var request = requestBuilder.put(path: "\(self.path)/\(slug)")
        request.httpBody = try? encoder.encode(data)
        taskForObject(request: request, completionHandler: completionHandler)
    }

    public func delete(_ remoteId: Int,
                       completionHandler: @escaping CodableHandler) {
        self.delete(slug: String(describing: remoteId), completionHandler: completionHandler)
    }

    public func delete(slug: String,
                       completionHandler: @escaping CodableHandler) {
        let request = requestBuilder.delete(path: "\(self.path)/\(slug)")
        taskForObject(request: request, completionHandler: completionHandler)
    }
}
