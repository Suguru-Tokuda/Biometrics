//
//  ContentView.swift
//  LocalAuthFrameowkrIntegration
//
//  Created by Suguru Tokuda on 12/19/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: LocalAuthenticationViewModel = LocalAuthenticationViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Local Authentication")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.blue)
                Spacer()
                TextField("Email", text: $vm.email)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    )
                SecureField("Password", text: $vm.password)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    )
                if let biometricType = vm.biometricType,
                   biometricType != .none {
                    Button(action: {
                        vm.authenticate()
                    }, label: {
                        Image(systemName: biometricType == .faceID ? "faceid" : "touchid")
                            .resizable()
                            .frame(width: 40, height: 40)
                    })
                    .navigationDestination(isPresented: $vm.authenticationSuccess, destination: {
                        AuthenticationSuccessView()
                    })
                    .alert("Authentication Error", isPresented: $vm.errorOccurred, actions: {
                        Button(action: {
                            vm.suppressError()
                        }, label: {
                            Text("OK")
                        })
                    }, message: {
                        Text(vm.authError?.localizedDescription ?? "")
                    })
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
