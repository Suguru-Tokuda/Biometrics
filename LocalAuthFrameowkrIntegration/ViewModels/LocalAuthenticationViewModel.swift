//
//  LocalAuthenticationViewModel.swift
//  LocalAuthFrameowkrIntegration
//
//  Created by Suguru Tokuda on 12/19/23.
//

import Foundation

class LocalAuthenticationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var biometricType: BiometricType?
    @Published var authenticationSuccess: Bool = false
    var localAuthManager: LocalAuthenticationManager?
    var authError: AuthenticationError?
    var errorOccurred = false
    
    init(localAuthManager: LocalAuthenticationManager = LocalAuthenticationManager()) {
        self.localAuthManager = localAuthManager
        
        DispatchQueue.main.async {
            self.biometricType = self.localAuthManager?.getBiometricType()
        }
    }
    
    func authenticate() {
        localAuthManager?.authenticateUser(email: self.email, password: self.password, completion: { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    self.authenticationSuccess = success
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.authError = error
                        self.errorOccurred = true
                    }
                }
            }
        })
    }
    
    func suppressError() {
        DispatchQueue.main.async {
            self.authError = nil
            self.errorOccurred = false
        }
    }
}
