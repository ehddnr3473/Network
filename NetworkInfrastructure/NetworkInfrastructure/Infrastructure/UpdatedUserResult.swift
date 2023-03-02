//
//  UpdatedUserResult.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

struct UpdatedUserResult: Decodable {
    let name: String
    let job: String
    let updatedAt: String
}
