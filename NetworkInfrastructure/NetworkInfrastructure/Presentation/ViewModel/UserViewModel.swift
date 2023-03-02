//
//  UserViewModel.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

final class UserViewModel: ObservableObject {
    private let networkService: NetworkService
    @Published var user: UserResult.User?
    @Published var postedUserResult: PostedUserResult?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getUserButtonTapped(id: String) {
        guard Int(id) != nil else { return }
        
        networkService.requestGet(httpMethod: .get, id: id) { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(UserResult.self, from: data)
                    DispatchQueue.main.async {
                        self.user = user.data
                    }
                } catch(let error) {
                    print(String(describing: error))
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func postUserButtonTapped(name: String, job: String) {
        networkService.requestPost(httpMethod: .post, user: UserToPost(name: name, job: job)) { result in
            switch result {
            case .success(let data):
                do {
                    let postedUserResult = try JSONDecoder().decode(PostedUserResult.self, from: data)
                    DispatchQueue.main.async {
                        self.postedUserResult = postedUserResult
                    }
                } catch(let error) {
                    print(String(describing: error))
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
