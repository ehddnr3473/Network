//
//  CustomUser.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

struct CustomUser {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    
    private init(id: Int,
                 email: String,
                 firstName: String,
                 lastName: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(user: UserResult.User) {
        self.id = user.id
        self.email = user.email
        self.firstName = user.firstName
        self.lastName = user.lastName
    }
}
