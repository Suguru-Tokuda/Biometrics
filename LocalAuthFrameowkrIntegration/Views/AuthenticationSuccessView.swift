//
//  AuthenticationSuccessView.swift
//  LocalAuthFrameowkrIntegration
//
//  Created by Suguru Tokuda on 12/19/23.
//

import SwiftUI

struct AuthenticationSuccessView: View {
    var body: some View {
        Text("Successfully Authenticated!")
            .font(.title2.weight(.bold))
            .foregroundStyle(.blue)
    }
}

#Preview {
    AuthenticationSuccessView()
}
