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
                     completionHandler: @escaping (DecodableResponseHandler<[T]>) -> Void) {
        let manager = CacheManager<[T]>()
        var decodedResponse = DecodableResponseHandler<[T]>()
        decodedResponse.decoder = self.decoder
        if let url = request.url {
            if cache, let content = manager.find(url: url) {
                decodedResponse.data = content
                decodedResponse.status = .success
                completionHandler(decodedResponse)
                return
            } else {
                manager.deleteFileFrom(url: url)
            }
        }
        let task = config.session.dataTask(with: request) { (data, response, error) in
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
        let manager = CacheManager<T>()
        var decodedResponse = DecodableResponseHandler<T>()
        decodedResponse.decoder = self.decoder
        if let url = request.url {
            if cache, let content = manager.find(url: url) {
                decodedResponse.data = content
                decodedResponse.status = .success
                completionHandler(decodedResponse)
                return
            } else {
                manager.deleteFileFrom(url: url)
            }
        }
        let task = config.session.dataTask(with: request) { (data, response, error) in
            decodedResponse.parse(data: data, response: response, error: error)
            DispatchQueue.main.async { completionHandler(decodedResponse) }
            if cache, let url = request.url, let decodedData = decodedResponse.data {
                _ = manager.save(url: url, rawData: data, jsonData: decodedData)
            }
        }
        task.resume()
    }
}
