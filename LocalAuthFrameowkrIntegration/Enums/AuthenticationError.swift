//
//  AuthenticationError.swift
//  LocalAuthFrameowkrIntegration
//
//  Created by Suguru Tokuda on 12/19/23.
//

import Foundation

enum AuthenticationError: Error {
    case credentialsNotSaved, deniedAccess, noFaceIdEnrolled, noFingerprintEnrolled, biometricError
}

extension AuthenticationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .credentialsNotSaved:
            return NSLocalizedString("Credentials are not saved.", comment: "credentialsNotSaved")
        case .deniedAccess:
            return NSLocalizedString("Access for biometric is denied.", comment: "deniedAccess")
        case .noFaceIdEnrolled:
            return NSLocalizedString("No FaceID is registered.", comment: "noFaceIdEnrolled")
        case .noFingerprintEnrolled:
            return NSLocalizedString("No Fingerprint is registered.", comment: "noFingerprintEnrolled")
        case .biometricError:
            return NSLocalizedString("Biometric Error", comment: "biometricError")
        }
    }
}
