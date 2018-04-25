//
//  DataClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class DataClient: Clientable {
    public let config: AmacaConfigurable
    public let path: String
    public let requestBuilder: RequestBuilder

    public init(config: AmacaConfigurable, path: String, auth: Authenticable?, contentType: String = "application/json") {
        self.config = config
        self.path = path
        self.requestBuilder = RequestBuilder(components: config.urlComponents(),
                                             auth: auth,
                                             contentType: contentType)
    }

    public func index(_ completionHandler: @escaping responseHandlerClojure) {
        let request = requestBuilder.get(path: self.path)
        let task = buildTaksFor(request: request, completionHandler: completionHandler)
        task.resume()
    }

    public func show(id: Int, completionHandler: @escaping responseHandlerClojure) {
        self.show(slug: String(describing: id), completionHandler: completionHandler)
    }

    public func show(slug: String, completionHandler: @escaping responseHandlerClojure) {
        let request = requestBuilder.get(path: "\(self.path)/\(slug)")
        let task = buildTaksFor(request: request, completionHandler: completionHandler)
        task.resume()
    }

    public func create(data: Data, completionHandler: @escaping responseHandlerClojure) {
        var request = requestBuilder.post(path: self.path)
        request.httpBody = data
        let task = buildTaksFor(request: request, completionHandler: completionHandler)
        task.resume()
    }

    public func update(id: Int, data: Data, completionHandler: @escaping responseHandlerClojure) {
        self.update(slug: String(describing: id), data: data, completionHandler: completionHandler)
    }

    public func update(slug: String, data: Data, completionHandler: @escaping responseHandlerClojure) {
        var request = requestBuilder.patch(path: "\(self.path)/\(slug)")
        request.httpBody = data
        let task = buildTaksFor(request: request, completionHandler: completionHandler)
        task.resume()
    }

    public func delete(id: Int, completionHandler: @escaping responseHandlerClojure) {
        self.delete(slug: String(describing: id), completionHandler: completionHandler)
    }

    public func delete(slug: String, completionHandler: @escaping responseHandlerClojure) {
        let request = requestBuilder.delete(path: "\(self.path)/\(slug)")
        let task = buildTaksFor(request: request, completionHandler: completionHandler)
        task.resume()
    }

    func buildTaksFor(request: URLRequest, completionHandler: @escaping responseHandlerClojure) -> URLSessionDataTask {
        return config.session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let unwrappedSelf = self else { return }
            let response = unwrappedSelf.buildResponse(data: data, response: response, error: error)
            DispatchQueue.main.async { completionHandler(response) }
        }
    }

    public func buildResponse(data: Data?, response: URLResponse?, error: Error?) -> ResponseHandler {
        return DataResponseHandler(data: data, response: response, error: error)
    }
}
