//
//  UserViewModel.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/02.
//

import Foundation

final class UserViewModel: ObservableObject {
    private let networkService: NetworkService
    @Published var user: CustomUser?
    @Published var customUserInformation: CustomUserInformation?
    @Published var result = ""
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getUserButtonTapped(id: String) {
        guard Int(id) != nil else { return }
        
        networkService.requestGet(httpMethod: .get, id: id) { result in
            switch result {
            case .success(let data):
                do {
                    let userResult = try JSONDecoder().decode(UserResult.self, from: data)
                    DispatchQueue.main.async {
                        self.result = "GET Succeeded!"
                        self.user = CustomUser(user: userResult.data)
                    }
                } catch(let error) {
                    DispatchQueue.main.async {
                        self.result = "GET failed!"
                    }
                    print(String(describing: error))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.result = "GET failed!"
                }
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
                        self.result = "POST Succeeded!"
                        self.customUserInformation = CustomUserInformation(postedUserResult: postedUserResult)
                    }
                } catch(let error) {
                    DispatchQueue.main.async {
                        self.result = "POST failed!"
                    }
                    print(String(describing: error))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.result = "POST failed!"
                }
                print(String(describing: error))
            }
        }
    }
    
    func putUserButtonTapped(id: String, name: String, job: String) {
        guard Int(id) != nil else { return }
        
        networkService.requestPut(httpMethod: .put, id: id, user: UserToPut(name: name, job: job)) { result in
            switch result {
            case .success(let data):
                do {
                    let updatedUserResult = try JSONDecoder().decode(UpdatedUserResult.self, from: data)
                    DispatchQueue.main.async {
                        self.result = "PUT Succeeded!"
                        self.customUserInformation = CustomUserInformation(id: id, updatedUserResult: updatedUserResult)
                    }
                } catch(let error) {
                    DispatchQueue.main.async {
                        self.result = "PUT failed!"
                    }
                    print(String(describing: error))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.result = "PUT failed!"
                }
                print(String(describing: error))
            }
            /*
             // PUT 메서드에 응답 데이터가 없는 경우
             switch result {
             case .success(let success):
                 if success {
                     DispatchQueue.main.async {
                         self.result = "PUT succeeded!"
                     }
                 } else {
                     print("Undefined code detected.")
                 }
             case .failure(let error):
                 DispatchQueue.main.async {
                     self.result = "PUT succeeded!"
                 }
                 print(String(describing: error))
             }
            */
        }
    }
    
    func deleteUserButtonTapped(id: String) {
        guard Int(id) != nil else { return }
        
        networkService.requestDelete(httpMethod: .delete, id: id) { result in
            switch result {
            case .success(let success):
                if success {
                    DispatchQueue.main.async {
                        self.result = "DELETE succeeded!"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.result = "DELETE failed!"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.result = "DELETE failed!"
                }
                print(String(describing: error))
            }
        }
    }
}
