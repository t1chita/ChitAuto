//
//  SignUpView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 03.07.24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            content
        }
        .background(Color.customBackground)
        .scrollIndicators(.hidden)
    }
    
    private var content: some View {
        VStack {
            appLogo
            
            usersInfoCard
            
            registrationButton
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
            CustomTextField(textFieldTitle: signUpViewModel.firstNameLabel,
                            textFieldText: $signUpViewModel.firstName)
            
            CustomTextField(textFieldTitle: signUpViewModel.lastNameLabel,
                            textFieldText: $signUpViewModel.lastName)
            
            CustomTextField(textFieldTitle: signUpViewModel.phoneNumberLabel,
                            textFieldText: $signUpViewModel.phoneNumber)
            
            CustomTextField(textFieldTitle: signUpViewModel.personalNoLabel,
                            textFieldText: $signUpViewModel.personalNo)
            
            CustomTextField(textFieldTitle: signUpViewModel.mailLabel,
                            textFieldText: $signUpViewModel.email)
            
            CustomTextField(textFieldTitle: signUpViewModel.passwordLabel,
                            textFieldText: $signUpViewModel.password)
        }
        .padding(.horizontal)
    }
    
    private var registrationButton: some View {
        RegistrationButtonRepresentable() {
            Task {
                try await signUpViewModel.createUser()
            }
        }
            .frame(height: 52)
            .padding(.top, 10)
            .padding(.horizontal, 50)
    }
}

struct RegistrationButtonRepresentable: UIViewRepresentable {
    let createUser: () -> ()
    
    func makeUIView(context: Context) -> CustomGeneralButton {
        let button = CustomGeneralButton()
        button.setTitle("რეგისტრაცია", for: .normal)
        button.addAction(UIAction(title: "Register User", handler: { _ in
            context.coordinator.handleRegistrationButtonTap()
        }), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: CustomGeneralButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(createUser: createUser, self)
    }
}


extension RegistrationButtonRepresentable {
    
    final class Coordinator: NSObject {
        let createUser: () -> ()
        
        let parent: RegistrationButtonRepresentable
        
        init(createUser: @escaping () -> Void, _ parent: RegistrationButtonRepresentable) {
            self.createUser = createUser
            self.parent = parent
        }
        
        func handleRegistrationButtonTap() {
            createUser()
        }
    }
}
