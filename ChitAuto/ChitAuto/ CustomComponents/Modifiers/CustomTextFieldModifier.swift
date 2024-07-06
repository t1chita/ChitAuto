//
//  CustomTextFieldModifier.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 06.07.24.
//

import SwiftUI

struct CustomTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
            .foregroundStyle(Color.customLabel)
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.customBackground)
            .cornerRadius(10)
    }
}

extension View {
    func textFieldStyle() -> some View {
        modifier(CustomTextFieldModifier())
    }
}
