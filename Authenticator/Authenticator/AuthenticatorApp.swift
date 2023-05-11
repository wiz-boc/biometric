//
//  AuthenticatorApp.swift
//  Authenticator
//
//  Created by wizz on 5/11/23.
//

import SwiftUI

@main
struct AuthenticatorApp: App {
    @StateObject var authenticationManager = AuthenticationManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authenticationManager)
        }
    }
}
