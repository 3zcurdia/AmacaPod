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
    let cacheManager = CacheManager<T>()

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
                     completionHandler: @escaping (DecodableResponseHandler<[T]>) -> Void) {
        let manager = CacheManager<[T]>()
        if cache, let url = request.url, let content = manager.find(url: url) {
            var decodedResponse = DecodableResponseHandler<[T]>()
            decodedResponse.data = content
            decodedResponse.status = .success
            completionHandler(decodedResponse)
            return
        } else if let url = request.url {
            manager.deleteFileFrom(url: url)
        }
        let task = config.session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let that = self else { return }
            var decodedResponse = DecodableResponseHandler<[T]>()
            decodedResponse.decoder = that.decoder
            decodedResponse.parse(data: data, response: response, error: error)
            DispatchQueue.main.async { completionHandler(decodedResponse) }
            if cache, let url = request.url, let decodedData = decodedResponse.data {
                _ = manager.save(url: url, rawData: data, jsonData: decodedData)
            }
        }
        task.resume()
    }

    public func taskFor(request: URLRequest, cache: Bool = false,
                     completionHandler: @escaping (DecodableResponseHandler<T>) -> Void) {
        let task = config.session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let that = self else { return }
            var decodedResponse = DecodableResponseHandler<T>()
            decodedResponse.decoder = that.decoder
            decodedResponse.parse(data: data, response: response, error: error)
            DispatchQueue.main.async { completionHandler(decodedResponse) }
            if cache, let url = request.url, let decodedData = decodedResponse.data {
                _ = that.cacheManager.save(url: url, rawData: data, jsonData: decodedData)
            }
        }
        task.resume()
    }
}
