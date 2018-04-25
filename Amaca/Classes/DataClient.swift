//
//  DataClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public typealias DataResponseHandlerClojure = (DataResponseHandler) -> Void

public class DataClient: Clientable {
    public let config: AmacaConfigurable
    public let path: String
    let requestBuilder: RequestBuilder

    public init(config: AmacaConfigurable, path: String,
                auth: Authenticable?, contentType: String = "application/json") {
        self.config = config
        self.path = path
        self.requestBuilder = RequestBuilder(components: config.urlComponents(),
                                             auth: auth,
                                             contentType: contentType)
    }

    func taskFor(request: URLRequest,
                 dataCompletionHandler: @escaping (DataResponseHandler) -> Void) -> URLSessionDataTask {
        return self.taskFor(request: request, completionHandler: { resp in
            guard let response = resp as? DataResponseHandler else { return }
            dataCompletionHandler(response)
        })
    }

    func taskFor(request: URLRequest, completionHandler: @escaping (ResponseHandler) -> Void) -> URLSessionDataTask {
        return config.session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let unwrappedSelf = self else { return }
            let response = unwrappedSelf.buildResponse(data: data, response: response, error: error)
            DispatchQueue.main.async { completionHandler(response) }
        }
    }

    func buildResponse(data: Data?, response: URLResponse?, error: Error?) -> ResponseHandler {
        return DataResponseHandler(data: data, response: response, error: error)
    }

}
