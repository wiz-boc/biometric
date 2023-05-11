//
//  AuthenticationManager.swift
//  Authenticator
//
//  Created by wizz on 5/11/23.
//

import Foundation
import LocalAuthentication

class AuthenticationManager: ObservableObject {
    private(set) var context = LAContext()
    @Published private(set) var biometryType: LABiometryType = .none
    private(set) var canEvaluatePolicy = false
    @Published private(set) var isAuthenticated = false
    @Published private(set) var errorDescription: String?
    @Published var showAlert = false
    
    init(){
        getBiometryType()
    }
    
    func getBiometryType(){
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometryType = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        context = LAContext()
        
        if canEvaluatePolicy {
            let reason = "Log into your account"
            do{
                let success = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)
                if success {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                }
            }catch{
                print("Something went wrong \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showAlert = true
                    self.biometryType = .none
                }
            }
        }
    }
}
