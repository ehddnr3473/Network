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
    func requestPut(httpMethod: HttpMethodType, id: String, user: UserToPut, completion: @escaping CompletionHandler)
    func requestDelete(httpMethod: HttpMethodType, id: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

public final class DefaultNetworkService: NetworkService {
    // MARK: - Private
    private func prepareRequest(_ endPoint: EndPoint, _ httpMethod: HttpMethodType, _ id: String) -> URLRequest {
        var urlComponents = URLComponents(string: endPoint.baseURL)
        urlComponents?.path = endPoint.path
        urlComponents?.path += "/"
        urlComponents?.path += id
        
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

// MARK: - GET
extension DefaultNetworkService {
    public func requestGet(httpMethod: HttpMethodType, id: String, completion: @escaping CompletionHandler) {
        let endPoint = EndPoint.default
        let request = prepareRequest(endPoint, httpMethod, id)
        makeRequest(request: request, completion: completion)
    }
}

// MARK: - POST
extension DefaultNetworkService {
    public func requestPost(httpMethod: HttpMethodType, user: UserToPost, completion: @escaping CompletionHandler) {
        let endPoint = EndPoint.default
        let request = preparePostRequest(endPoint, httpMethod, user)
        makeRequest(request: request, completion: completion)
    }
    
    // MARK: - Private
    private func preparePostRequest<BodyType: Encodable>(_ endPoint: EndPoint, _ httpMethod: HttpMethodType, _ body: BodyType) -> URLRequest {
        var urlComponents = URLComponents(string: endPoint.baseURL)
        urlComponents?.path = endPoint.path
        
        var request = URLRequest(url: urlComponents!.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = try? JSONEncoder().encode(body)
        
        return request
    }
}

// MARK: - PUT
extension DefaultNetworkService {
    public func requestPut(httpMethod: HttpMethodType, id: String, user: UserToPut, completion: @escaping CompletionHandler) {
        let endPoint = EndPoint.default
        let request = preparePutRequest(endPoint, httpMethod, id, user)
        makeRequest(request: request, completion: completion)
    }
    
    // MARK: - Private
    private func preparePutRequest<BodyType: Encodable>(_ endPoint: EndPoint, _ httpMethod: HttpMethodType, _ id: String, _ body: BodyType) -> URLRequest {
        var urlComponents = URLComponents(string: endPoint.baseURL)
        urlComponents?.path = endPoint.path
        urlComponents?.path += "/"
        urlComponents?.path += id
        
        var request = URLRequest(url: urlComponents!.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = try? JSONEncoder().encode(body)
        
        return request
    }
    
    // PUT 메서드에 응답 데이터가 없는 경우
    private func makePutRequest(request: URLRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            }
        }
        
        task.resume()
    }
}

// MARK: - DELETE
extension DefaultNetworkService {
    public func requestDelete(httpMethod: HttpMethodType, id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let endPoint = EndPoint.default
        let request = prepareRequest(endPoint, httpMethod, id)
        makeDeleteRequest(request: request, completion: completion)
    }
    
    // MARK: - Private
    private func makeDeleteRequest(request: URLRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
                if response.statusCode == 204 {
                    completion(.success(true))
                }
            }
        }
        
        task.resume()
    }
}
