//
//  NetworkInfrastructureApp.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/01.
//

import SwiftUI

@main
struct NetworkInfrastructureApp: App {
    let viewModel = UserViewModel(networkService: DefaultNetworkService())
    
    var body: some Scene {
        WindowGroup {
            UserView(viewModel: viewModel)
        }
    }
}
