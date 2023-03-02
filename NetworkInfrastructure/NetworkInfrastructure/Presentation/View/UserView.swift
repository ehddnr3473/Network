//
//  UserView.swift
//  NetworkInfrastructure
//
//  Created by 김동욱 on 2023/03/01.
//

import SwiftUI

struct UserView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: UserViewModel
    @State var id = ""
    @State var putId = ""
    @State var name = ""
    @State var job = ""
    
    var isIdValid: Bool {
        !id.isEmpty && Int(id) != nil
    }
    
    var isPostValid: Bool {
        !name.isEmpty && !job.isEmpty
    }
    
    var isPutValid: Bool {
        !putId.isEmpty &&
        Int(putId) != nil &&
        isPostValid
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            resultBody
            
            userInformationBody
            
            submitBody
            
            submitResultsBody
            
            HStack {
                Button("GET USER") {
                    if !id.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.getUserButtonTapped(id: id)
                        id = ""
                    }
                }
                .frame(width: 120, height: 40)
                .border(.secondary)
                .disabled(!isIdValid)
                
                Button("POST USER") {
                    if !name.trimmingCharacters(in: .whitespaces).isEmpty &&
                        !job.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.postUserButtonTapped(name: name, job: job)
                        name = ""
                        job = ""
                    }
                }
                .frame(width: 120, height: 40)
                .border(.secondary)
                .disabled(!isPostValid)
            }
            
            HStack {
                Button("PUT USER") {
                    if !putId.trimmingCharacters(in: .whitespaces).isEmpty &&
                        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
                        !job.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.putUserButtonTapped(id: putId, name: name, job: job)
                        name = ""
                        job = ""
                        putId = ""
                    }
                }
                .frame(width: 120, height: 40)
                .border(.secondary)
                .disabled(!isPutValid)
                
                Button("DELETE USER") {
                    if !id.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.deleteUserButtonTapped(id: id)
                        id = ""
                    }
                }
                .frame(width: 120, height: 40)
                .border(.secondary)
                .disabled(!isIdValid)
            }
        }
    }
    
    // MARK: - Result view
    var resultBody: some View {
        HStack {
            Text("Result: ")
                .font(.system(.headline, weight: .bold))
            Text(viewModel.result)
            Spacer()
        }
        .padding(.leading)
    }
    
    // MARK: - User information view
    var userInformationBody: some View {
        VStack {
            Text("User Information")
                .font(.system(.title3, weight: .bold))
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
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.cyan)
                    .shadow(radius: 2)
            }
            
            TextField("Type ID for GET or DELETE", text: $id)
        }
        .padding()
    }
    
    // MARK: - Submit form view
    var submitBody: some View {
        VStack {
            Text("Submit form")
                .font(.system(.title3, weight: .bold))
            
            VStack(spacing: 8) {
                HStack {
                    Text("ID: ")
                        .fontWeight(.bold)
                    TextField("Type your ID for PUT", text: $putId)
                }
                
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
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.pink)
                    .shadow(radius: 2)
            }
        }
        .padding()
    }
    
    // MARK: - Submit results view
    var submitResultsBody: some View {
        VStack {
            Text("Submit Results")
                .font(.system(.title3, weight: .bold))
            
            VStack(spacing: 8) {
                HStack {
                    Text("ID: ")
                        .fontWeight(.bold)
                    Text(viewModel.customUserInformation?.id ?? "")
                    Spacer()
                }
                
                HStack {
                    Text("Name: ")
                        .fontWeight(.bold)
                    Text(viewModel.customUserInformation?.name ?? "")
                    Spacer()
                }
                
                HStack {
                    Text("Job: ")
                        .fontWeight(.bold)
                    Text(viewModel.customUserInformation?.job ?? "")
                    Spacer()
                }
                
                HStack {
                    Text("At: ")
                        .fontWeight(.bold)
                    Text(viewModel.customUserInformation?.at ?? "")
                    Spacer()
                }
            }
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.indigo)
                    .shadow(radius: 2)
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let networkService = DefaultNetworkService()
        let viewModel = UserViewModel(networkService: networkService)
        UserView(viewModel: viewModel)
    }
}
