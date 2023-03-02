//
//  UserToPost.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

public struct UserToPost: Codable {
    let name: String
    let job: String
}

public struct UserPostedResult: Codable {
    let name: String
    let job: String
    let id: String
    let createdAt: String
}
