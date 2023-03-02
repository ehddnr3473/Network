//
//  CustomUserInformation.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

struct CustomUserInformation {
    let id: String
    let name: String
    let job: String
    let at: String
    
    private init(id: String,
                 name: String,
                 job: String,
                 at: String) {
        self.id = id
        self.name = name
        self.job = job
        self.at = at
    }
    
    init(id: String, updatedUserResult: UpdatedUserResult) {
        self.id = id
        self.name = updatedUserResult.name
        self.job = updatedUserResult.job
        self.at = updatedUserResult.updatedAt
    }
    
    init(postedUserResult: PostedUserResult) {
        self.id = postedUserResult.id
        self.name = postedUserResult.name
        self.job = postedUserResult.job
        self.at = postedUserResult.createdAt
    }
}
