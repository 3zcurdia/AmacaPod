//
//  CodableClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class CodableClient<T>: Clientable where T: Codable {
    let config: AmacaConfigurable
    let path: String
    let requestBuilder: RequestBuilder

    public var encoder: JSONEncoder = JSONEncoder()
    public var decoder: JSONDecoder = JSONDecoder()

    public init(config: AmacaConfigurable, path: String,
                auth: Authenticable?, contentType: String = "application/json") {
        self.config = config
        self.path = path
        self.requestBuilder = RequestBuilder(components: config.urlComponents(),
                                             auth: auth,
                                             contentType: contentType)
    }

    public func listTaskFor(request: URLRequest, cache: Bool = false,
                     completionHandler: @escaping (DecodableResponseHandler<[T]>) -> Void) -> URLSessionDataTask {
        // if cached { fetch && return }
        return config.session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let that = self else { return }
            var decodedResponse = DecodableResponseHandler<[T]>()
            decodedResponse.decoder = that.decoder
            decodedResponse.parse(data: data, response: response, error: error)
            // delete cache if present
            // save cache if enabled
            DispatchQueue.main.async { completionHandler(decodedResponse) }
        }
    }

    public func taskFor(request: URLRequest, cache: Bool = false,
                     completionHandler: @escaping (DecodableResponseHandler<T>) -> Void) -> URLSessionDataTask {
        return config.session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let that = self else { return }
            var decodedResponse = DecodableResponseHandler<T>()
            decodedResponse.decoder = that.decoder
            decodedResponse.parse(data: data, response: response, error: error)
            DispatchQueue.main.async { completionHandler(decodedResponse) }
        }
    }
}
