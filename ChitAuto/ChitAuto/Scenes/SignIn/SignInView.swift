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
            
            signInButton
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
                            textFieldText: $signInViewModel.mail)
            
            CustomTextField(textFieldTitle: signInViewModel.passwordLabel,
                            textFieldText: $signInViewModel.password)
            }
        .padding(.horizontal)
    }
    
    private var signInButton: some View {
        SignInButtonRepresentable()
            .frame(height: 52)
            .padding(.top, 20)
            .padding(.horizontal, 50)
    }
}


struct SignInButtonRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomGeneralButton {
        let button = CustomGeneralButton()
        button.setTitle("შესვლა", for: .normal)
        return button
    }
    
    func updateUIView(_ uiView: CustomGeneralButton, context: Context) {
        
    }
}

#Preview {
    SignInView()
}
