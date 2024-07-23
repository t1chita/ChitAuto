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
            .padding(.horizontal, 24)

    }
    
    private var usersInfoCardContent: some View {
        VStack {
            CustomTextField(textFieldTitle: signUpViewModel.firstNameLabel, 
                            placeHolder: "მაგ: თემურ",
                            isSecureField: false,
                            textFieldText: $signUpViewModel.firstName)
            
            CustomTextField(textFieldTitle: signUpViewModel.lastNameLabel,
                            placeHolder: "მაგ: ჩიტაშვილი",
                            isSecureField: false,
                            textFieldText: $signUpViewModel.lastName)
            
            CustomTextField(textFieldTitle: signUpViewModel.mailLabel,
                            placeHolder: "მაგ: example@gmail.com",
                            isSecureField: false,
                            textFieldText: $signUpViewModel.email)
            
            CustomTextField(textFieldTitle: signUpViewModel.passwordLabel,
                            placeHolder: "მაგ: rkvkai1.",
                            isSecureField: true,
                            textFieldText: $signUpViewModel.password)
            
            countryPicker
            
            registrationButton
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
    
    private var countryPicker: some View {
        VStack(alignment: .leading) {
            Text("მობილურის ნომერი")
                .padding(.leading, 10)
            HStack {
                Button {
                    signUpViewModel.countryPickerIsPresented.toggle()
                } label: {
                    Text("\(signUpViewModel.countryFlag)\(signUpViewModel.countryDialCode)")
                        .padding(10)
                        .frame(minWidth: 80, minHeight: 52)
                        .background(.customBackground, in:
                                        RoundedRectangle(cornerRadius: 10,
                                                         style: .continuous))
                        .foregroundStyle(.customLabel)
                }
                
                TextField("",
                          text: $signUpViewModel.phoneNumber)
                .textFieldStyle()
            }
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $signUpViewModel.countryPickerIsPresented) {
            countriesSheet
        }
    }
    
    private var countriesSheet: some View {
        NavigationStack {
            List(signUpViewModel.filteredCountries) { country in
                countriesCell(for: country)
            }
        }
        .searchable(text: $signUpViewModel.searchForCountry, prompt: "მოძებნე ქვეყანა")
        .presentationDetents([.medium, .large])
    }
    
    private func countriesCell(for country: CountryResponse) -> some View {
        HStack {
            Text(country.flag)
            
            Text(country.name)
                .font(.body)
            
            Spacer()
            Text(country.dialCode)
                .foregroundStyle(Color(UIColor.systemGray2))
        }
        .onTapGesture {
            signUpViewModel.countryFlag = country.flag
            signUpViewModel.countryDialCode = country.dialCode
            signUpViewModel.countryPickerIsPresented = false
        }
    }
    
    private var registrationButton: some View {
        RegistrationButtonRepresentable() {
            Task {
                try await signUpViewModel.createUser()
            }
        }
        .opacity(signUpViewModel.formIsValid ? 1.0 : 0.5)
        .disabled(!signUpViewModel.formIsValid)
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


