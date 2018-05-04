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
    let requestBuilder: RequestBuilder

    public init(config: AmacaConfigurable, path: String,
                auth: Authenticable?, contentType: String = "application/json") {
        self.config = config
        self.path = path
        self.requestBuilder = RequestBuilder(components: config.urlComponents(),
                                             auth: auth,
                                             contentType: contentType)
    }

    public func taskFor(request: URLRequest,
                        completionHandler: @escaping (DataResponseHandler) -> Void) -> URLSessionDataTask {
        return config.session.dataTask(with: request) { (data, response, error) in
            let response = DataResponseHandler(data: data, response: response, error: error)
            DispatchQueue.main.async { completionHandler(response) }
        }
    }
}
