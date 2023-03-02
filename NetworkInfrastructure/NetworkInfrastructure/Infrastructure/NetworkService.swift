//
//  NetworkService.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

public protocol NetworkService: AnyObject {
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    
    func requestGet(httpMethod: HttpMethodType, id: String, completion: @escaping CompletionHandler)
    func requestPost(httpMethod: HttpMethodType, user: UserToPost, completion: @escaping CompletionHandler)
}

public final class DefaultNetworkService: NetworkService {
    public func requestGet(httpMethod: HttpMethodType, id: String, completion: @escaping CompletionHandler) {
        let endPoint = EndPoint.default
        let request = prepareRequestGet(endPoint, httpMethod, id)
        makeRequest(request: request, completion: completion)
    }
    
    public func requestPost(httpMethod: HttpMethodType, user: UserToPost, completion: @escaping CompletionHandler) {
        let endPoint = EndPoint.default
        let request = prepareRequestPost(endPoint, httpMethod, user)
        makeRequest(request: request, completion: completion)
    }
    
    private func prepareRequestGet(_ endPoint: EndPoint, _ httpMethod: HttpMethodType, _ id: String) -> URLRequest {
        var urlComponents = URLComponents(string: endPoint.baseURL)
        urlComponents?.path = endPoint.path
        urlComponents?.path += "/"
        urlComponents?.path += id
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    private func prepareRequestPost<BodyType: Encodable>(_ endPoint: EndPoint, _ httpMethod: HttpMethodType, _ body: BodyType) -> URLRequest {
        var urlComponents = URLComponents(string: endPoint.baseURL)
        urlComponents?.path = endPoint.path
        var request = URLRequest(url: urlComponents!.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = try? JSONEncoder().encode(body)
        
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
