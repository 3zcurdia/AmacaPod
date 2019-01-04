//
//  RESTDataClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class DataService: DataClient {
    public func index(_ completionHandler: @escaping (DataResponseHandler) -> Void) {
        let request = requestBuilder.get(path: self.path)
        task(request: request, completionHandler: completionHandler)
    }

    public func show(_ remoteId: Int,
                     completionHandler: @escaping (DataResponseHandler) -> Void) {
        self.show(slug: String(describing: remoteId), completionHandler: completionHandler)
    }

    public func show(slug: String,
                     completionHandler: @escaping (DataResponseHandler) -> Void) {
        let request = requestBuilder.get(path: "\(self.path)/\(slug)")
        task(request: request, completionHandler: completionHandler)
    }

    public func create(data: Data,
                       completionHandler: @escaping (DataResponseHandler) -> Void) {
        var request = requestBuilder.post(path: self.path)
        request.httpBody = data
        task(request: request, completionHandler: completionHandler)
    }

    public func update(_ remoteId: Int, data: Data,
                       completionHandler: @escaping (DataResponseHandler) -> Void) {
        self.update(slug: String(describing: remoteId), data: data, completionHandler: completionHandler)
    }

    public func update(slug: String, data: Data,
                       completionHandler: @escaping (DataResponseHandler) -> Void) {
        var request = requestBuilder.put(path: "\(self.path)/\(slug)")
        request.httpBody = data
        task(request: request, completionHandler: completionHandler)
    }

    public func delete(_ remoteId: Int,
                       completionHandler: @escaping (DataResponseHandler) -> Void) {
        self.delete(slug: String(describing: remoteId), completionHandler: completionHandler)
    }

    public func delete(slug: String,
                       completionHandler: @escaping (DataResponseHandler) -> Void) {
        let request = requestBuilder.delete(path: "\(self.path)/\(slug)")
        task(request: request, completionHandler: completionHandler)
    }
}
