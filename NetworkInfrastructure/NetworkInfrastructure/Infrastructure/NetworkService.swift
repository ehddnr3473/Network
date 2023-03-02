//
//  NetworkService.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

public protocol NetworkService: AnyObject {
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    
    func request(httpMethod: HttpMethodType, completion: @escaping CompletionHandler)
}

public final class DefaultNetworkService: NetworkService {
    public func request(httpMethod: HttpMethodType, completion: @escaping CompletionHandler) {
        let endPoint = EndPoint.default
        let request = prepareRequest(endPoint, httpMethod)
        makeRequest(request: request, completion: completion)
    }
    
    private func prepareRequest(_ endPoint: EndPoint, _ httpMethod: HttpMethodType) -> URLRequest {
        var urlComponents = URLComponents(string: endPoint.baseURL)
        urlComponents?.path = endPoint.path
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    private func makeRequest(request: URLRequest, completion: @escaping CompletionHandler) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}
