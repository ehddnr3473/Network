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
