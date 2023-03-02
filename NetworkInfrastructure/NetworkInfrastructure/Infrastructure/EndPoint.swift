//
//  EndPoint.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/01.
//

import Foundation

/// HTTP Method
/// - GET: 서버에서 자원의 상태를 조회하기 위해 사용되는 메서드
/// - POST: 클라이언트에서 서버로 자원을 생성하기 위해 사용되는 메서드
/// - PUT: 클라이언트에서 서버로 자원을 업데이트하기 위해 사용되는 메서드
/// - DELETE: 클라이언트에서 서버로 자원을 삭제하기 위해 사용되는 메서드
/// - PATCH: PUT과 유사하지만, PUT과 달리 전체 자원을 업데이트하지 않고 일부분만 업데이트함.
/// - HEAD: GET과 유사하지만, 서버에서 응답으로 바디를 제외한 헤더 정보만을 반환. 자원의 존재 유무나 갱신 시간 등을 확인할 때 사용됨.
/// - OPTIONS: 서버에서 지원하는 메서드, 헤더, 허용된 요청 페이로드 등을 조회하기 위해 사용됨.
public enum HttpMethodType: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
    case head   = "HEAD"
    case patch  = "PATCH"
}


/// EndPoint
/// REST API에서 클라이언트가 서버의 특정 기능을 호출하기 위해 필요한 URI의 일부분
/// API에서 제공하는 각각의 기능이나 자원에 대한 경로(여기에서는 URL)
/// EndPoint는 HTTP 메서드와 함께 사용되어, 클라이언트가 서버에 요청을 보낼 때
/// 어떤 EndPoint에 어떤 HTTP 메서드를 사용해야 하는지를 결정.
/// path + query item
public enum EndPoint {
    case `default`
}

public extension EndPoint {
    var baseURL: String {
        switch self {
        case .`default`:
            return "https://reqres.in"
        }
    }
    
    var path: String {
        switch self {
        case .`default`:
            return "/api/users"
        }
    }
}
