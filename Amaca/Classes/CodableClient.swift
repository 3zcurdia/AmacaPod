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
        return self.taskFor(request: request, completionHandler: { resp in
            guard let response = resp as? DecodableResponseHandler<[T]> else { return }
            codableCompletionHandler(response)
        })
    }

    typealias DecodableResponseHandlerClojure = (DecodableResponseHandler<T>) -> Void
    func taskFor(request: URLRequest,
                 codableCompletionHandler: @escaping DecodableResponseHandlerClojure) -> URLSessionDataTask {
        return self.taskFor(request: request, completionHandler: { resp in
            guard let response = resp as? DecodableResponseHandler<T> else { return }
            codableCompletionHandler(response)
        })
    }
}
