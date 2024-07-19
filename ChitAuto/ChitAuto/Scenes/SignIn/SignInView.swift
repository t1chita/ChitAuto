//
//  SignInView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 06.07.24.
//

import SwiftUI

struct SignInView: View {
    @StateObject var signInViewModel = SignInViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            content
        }
        .background(Color.customBackground)
        .scrollDisabled(true)
        .scrollIndicators(.hidden)
    }
    
    private var content: some View {
        VStack {
            appLogo
            
            usersInfoCard
        }
    }
    
    private var appLogo: some View {
        Image(.logo)
            .resizable()
            .frame(width: 180, height: 180)
            .scaledToFill()
    }
    
    private var usersInfoCard: some View {
        ZStack {
            usersInfoCardBackground
            
            usersInfoCardContent
        }
    }
    
    private var usersInfoCardBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(Color.customCard)
            .padding(.vertical, -10)
            .padding(.horizontal, 24)
    }
    
    private var usersInfoCardContent: some View {
        VStack {
            CustomTextField(textFieldTitle: signInViewModel.mailLabel, 
                            placeHolder: "მეილი",
                            isSecureField: false,
                            textFieldText: $signInViewModel.mail)
            
            CustomTextField(textFieldTitle: signInViewModel.passwordLabel,
                            placeHolder: "მაგ: rkvkai1.",
                            isSecureField: true,
                            textFieldText: $signInViewModel.password)
            
            signInButton
        }
        .padding(.horizontal)
    }
    
    private var signInButton: some View {
        SignInButtonRepresentable() {
            Task {
                try await signInViewModel.singIn()
            }
        }
        .opacity(signInViewModel.formIsValid ? 1.0 : 0.5)
        .frame(height: 52)
        .padding(.top, 20)
        .padding(.horizontal, 50)
    }
}

struct SignInButtonRepresentable: UIViewRepresentable {
    let signInUser: () -> ()
    
    func makeUIView(context: Context) -> CustomGeneralButton {
        let button = CustomGeneralButton()
        button.setTitle("შესვლა", for: .normal)
        button.addAction(UIAction(title: "Register User", handler: { _ in
            context.coordinator.handleSignInButtonTap()
        }), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: CustomGeneralButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(signInUser: signInUser, self)
    }
}


extension SignInButtonRepresentable {
    
    final class Coordinator: NSObject {
        let signInUser: () -> ()
        
        let parent: SignInButtonRepresentable
        
        init(signInUser: @escaping () -> Void, _ parent: SignInButtonRepresentable) {
            self.signInUser = signInUser
            self.parent = parent
        }
        
        func handleSignInButtonTap() {
            signInUser()
        }
    }
}


