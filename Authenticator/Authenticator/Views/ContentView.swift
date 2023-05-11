//
//  ContentView.swift
//  Authenticator
//
//  Created by wizz on 5/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager
    var body: some View {
        NavigationView {
            VStack {
                if authenticationManager.isAuthenticated {
                    VStack(spacing: 40){
                        Title()
                        Text("Welcome in you are now authenticated")
                            .foregroundColor(.white)
                        PrimaryButton(showImage: false, text: "Logout")
                            .onTapGesture {
                                authenticationManager.logout()
                            }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(LinearGradient(colors: [.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                }else{
                    LoginView()
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $authenticationManager.showAlert) {
                Alert(title: Text("Error"), message: Text(authenticationManager.errorDescription ?? "Error trying to login with credentials, please try again"), dismissButton: .default(Text("OK")))
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthenticationManager())
    }
}
