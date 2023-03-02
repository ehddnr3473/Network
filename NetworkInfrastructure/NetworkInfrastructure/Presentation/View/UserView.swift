//
//  UserView.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/01.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel
    @State var name = ""
    @State var job = ""
    
    var body: some View {
        VStack {
            userInformationBody
            
            inputBody
            
            Spacer()
            
            HStack {
                Button("GET USER") {
                    viewModel.getUserButtonTapped()
                }
                .frame(width: 120, height: 50)
                .border(.secondary)
                
                Button("POST USER") {
                    if !name.trimmingCharacters(in: .whitespaces).isEmpty &&
                        !job.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.postUserButtonTapped(name: name, job: job)
                    }
                }
                .frame(width: 120, height: 50)
                .border(.secondary)
            }
            
            HStack {
                Button("PUT USER") {
//                    viewModel.putUserButtonTapped()
                }
                .frame(width: 120, height: 50)
                .border(.secondary)
                
                Button("DELETE USER") {
//                    viewModel.deleteUserButtonTapped()
                }
                .frame(width: 120, height: 50)
                .border(.secondary)
            }
        }
    }
    
    var userInformationBody: some View {
        VStack {
            Text("User Information")
                .font(.system(.title2, weight: .bold))
                .padding(.bottom)
            
            VStack(spacing: 8) {
                HStack {
                    Text("ID: ")
                        .fontWeight(.bold)
                    if let id = viewModel.user?.id {
                        Text(String(id))
                    } else {
                        Text("")
                    }
                    Spacer()
                }
                
                HStack {
                    Text("Email: ")
                        .fontWeight(.bold)
                    Text(viewModel.user?.email ?? "")
                    Spacer()
                }
                
                HStack {
                    Text("FirstName: ")
                        .fontWeight(.bold)
                    Text(viewModel.user?.firstName ?? "")
                    Spacer()
                }
                
                HStack {
                    Text("LastName: ")
                        .fontWeight(.bold)
                    Text(viewModel.user?.lastName ?? "")
                    Spacer()
                }
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.cyan)
                    .shadow(radius: 2)
            }
        }
        .padding()
    }
    
    var inputBody: some View {
        VStack {
            Text("Submit form")
                .font(.system(.title2, weight: .bold))
                .padding(.bottom)
            
            VStack(spacing: 8) {
                HStack {
                    Text("Name: ")
                        .fontWeight(.bold)
                    TextField("Type your name..", text: $name)
                }
                
                HStack {
                    Text("Job: ")
                        .fontWeight(.bold)
                    TextField("Type your job..", text: $job)
                }
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.pink)
                    .shadow(radius: 2)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let networkService = DefaultNetworkService()
        let viewModel = UserViewModel(networkService: networkService)
        UserView(viewModel: viewModel)
    }
}
