//
//  User.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

public struct UserResult: Decodable {
    let data: User
    
    public struct User: Decodable {
        let id: Int
        let email: String
        let firstName: String
        let lastName: String
        let avatar: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case email
            case firstName = "first_name"
            case lastName = "last_name"
            case avatar
        }
    }
}
