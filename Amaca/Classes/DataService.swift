//
//  RESTDataClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class DataService: DataClient {
    public func index(_ completionHandler: @escaping DataResponseHandlerClojure) {
        let request = requestBuilder.get(path: self.path)
        let task = taskFor(request: request, dataCompletionHandler: completionHandler)
        task.resume()
    }

    public func show(_ remoteId: Int,
                     completionHandler: @escaping DataResponseHandlerClojure) {
        self.show(slug: String(describing: remoteId), completionHandler: completionHandler)
    }

    public func show(slug: String,
                     completionHandler: @escaping DataResponseHandlerClojure) {
        let request = requestBuilder.get(path: "\(self.path)/\(slug)")
        let task = taskFor(request: request, dataCompletionHandler: completionHandler)
        task.resume()
    }

    public func create(data: Data,
                       completionHandler: @escaping DataResponseHandlerClojure) {
        var request = requestBuilder.post(path: self.path)
        request.httpBody = data
        let task = taskFor(request: request, dataCompletionHandler: completionHandler)
        task.resume()
    }

    public func update(_ remoteId: Int, data: Data,
                       completionHandler: @escaping DataResponseHandlerClojure) {
        self.update(slug: String(describing: remoteId), data: data, completionHandler: completionHandler)
    }

    public func update(slug: String, data: Data,
                       completionHandler: @escaping DataResponseHandlerClojure) {
        var request = requestBuilder.patch(path: "\(self.path)/\(slug)")
        request.httpBody = data
        let task = taskFor(request: request,
                           dataCompletionHandler: completionHandler)
        task.resume()
    }

    public func delete(_ remoteId: Int,
                       completionHandler: @escaping DataResponseHandlerClojure) {
        self.delete(slug: String(describing: remoteId), completionHandler: completionHandler)
    }

    public func delete(slug: String,
                       completionHandler: @escaping DataResponseHandlerClojure) {
        let request = requestBuilder.delete(path: "\(self.path)/\(slug)")
        let task = taskFor(request: request, dataCompletionHandler: completionHandler)
        task.resume()
    }
}
