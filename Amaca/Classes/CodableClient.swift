//
//  CodableClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class CodableClient<T>: DataClient where T: Codable {
    typealias DecodableResponseHandlerListClojure = (DecodableResponseHandler<[T]>) -> Void
    func listTaskFor(request: URLRequest,
                     codableCompletionHandler: @escaping DecodableResponseHandlerListClojure) -> URLSessionDataTask {
        return config.session.dataTask(with: request) { (data, response, error) in
            let response = DecodableResponseHandler<[T]>(data: data, response: response, error: error)
            DispatchQueue.main.async { codableCompletionHandler(response) }
        }
    }

    typealias DecodableResponseHandlerClojure = (DecodableResponseHandler<T>) -> Void
    func taskFor(request: URLRequest,
                 codableCompletionHandler: @escaping DecodableResponseHandlerClojure) -> URLSessionDataTask {
        return self.taskFor(request: request, completionHandler: { resp in
            guard let response = resp as? DecodableResponseHandler<T> else { return }
            codableCompletionHandler(response)
        })
    }

    override func buildResponse(data: Data?, response: URLResponse?, error: Error?) -> ResponseHandler {
        return DecodableResponseHandler<T>(data: data, response: response, error: error)
    }
}
