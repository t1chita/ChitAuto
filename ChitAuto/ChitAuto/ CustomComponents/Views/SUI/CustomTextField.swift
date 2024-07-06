//
//  CustomTextField.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 06.07.24.
//

import SwiftUI

struct CustomTextField: View {
    let textFieldTitle: String
    
    @Binding var textFieldText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(textFieldTitle)
                .padding(.leading, 10)
            
            TextField(textFieldText,
                      text: $textFieldText)
            .textFieldStyle()
        }
        .padding(.horizontal, 16)
    }
}
