//
//  BiometricManager.swift
//  LocalAuthFrameowkrIntegration
//
//  Created by Suguru Tokuda on 12/19/23.
//

import Foundation
import LocalAuthentication

protocol LocalAuthencationLogic {
    func getBiometricType() -> BiometricType
    func authenticateUser(email: String, password: String, completion: @escaping (Result<Bool, AuthenticationError>) -> Void)
}

class LocalAuthenticationManager: LocalAuthencationLogic {
    func getBiometricType() -> BiometricType {
        let authContext = LAContext()
        let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        
        switch authContext.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        case .opticID:
            return .none
        @unknown default:
            return .none
        }
    }
    
    func authenticateUser(email: String, password: String, completion: @escaping (Result<Bool, AuthenticationError>) -> Void) {
        let credentials: Credentials? = Credentials(email: email, password: password)
        
        guard let credentials else {
            completion(.failure(.credentialsNotSaved))
            return
        }
        
        let context = LAContext()
        var error: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        if let error {
            switch error.code {
            case -6:
                completion(.failure(.deniedAccess))
            case -7:
                if context.biometryType == .faceID {
                    completion(.failure(.noFaceIdEnrolled))
                } else {
                    completion(.failure(.noFingerprintEnrolled))
                }
            default:
                completion(.failure(.biometricError))
            }
            
            return
        }
        
        if canEvaluate && context.biometryType != .none {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Need to access credentials.") { success, error in
                if error != nil {
                    completion(.failure(.biometricError))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
}

