//
//  RESTCodableClient.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 4/25/18.
//

import Foundation

public class CodableService<T>: CodableClient<T> where T: Codable {
    public func index(_ completionHandler: @escaping (DecodableResponseHandler<[T]>) -> Void) {
        let request = requestBuilder.get(path: self.path)
        let task = listTaskFor(request: request, codableCompletionHandler: completionHandler)
        task.resume()
    }

    //    typealias codableHandlerClojure = (DecodableResponseHandler<T>) -> Void
    //
    //    func create(data: T,
    //                completionHandler: @escaping codableHandlerClojure) {
    //        var request = requestBuilder.post(path: self.path)
    //        request.httpBody = try? JSONEncoder().encode(data)
    //        let task = buildTaskFor(request: request, completionHandler: completionHandler)
    //        task.resume()
    //    }
    //
    //    func update(id: Int, data: T,
    //                completionHandler: @escaping codableHandlerClojure) {
    //        self.update(slug: String(describing: id), data: data, completionHandler: completionHandler)
    //    }
    //
    //    func update(slug: String, data: T,
    //                completionHandler: @escaping codableHandlerClojure) {
    //        var request = requestBuilder.patch(path: "\(self.path)/\(slug)")
    //        request.httpBody = try? JSONEncoder().encode(data)
    //        let task = buildTaskFor(request: request, completionHandler: completionHandler)
    //        task.resume()
    //    }
    //
    //    func buildTaskFor(request: URLRequest,
    //                      completionHandler: @escaping codableHandlerClojure) -> URLSessionDataTask {
    //        return config.session.dataTask(with: request) { [weak self] (data, response, error) in
    //            guard let unwrappedSelf = self else { return }
    //            guard let response = unwrappedSelf.buildResponse(data: data,
    // response: response, error: error) as? DecodableResponseHandler<T> else { return }
    //            DispatchQueue.main.async { completionHandler(response) }
    //        }
    //    }
    //
    //    public func buildResponse(data: Data?,
    //                              response: URLResponse?, error: Error?) -> ResponseHandler {
    //        return DecodableResponseHandler<T>(data: data, response: response, error: error)
    //    }
}
