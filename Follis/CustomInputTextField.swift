//
//  CustomInputTextField.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct CustomInputTextField: View {
    
    
    // MARK: - PROPERTIES
    let isSecureField: Bool?
    let placeholderText: String
    let title: String
    let bottomMessage: String
    let confirmText: Bool?
    @Binding var text: String
    @Binding var confirmPassword: String
    @State var passwordStrength = ""
    @State var strongPassword = false
    @State var passwordMatchMessage = ""
    @State var passwordMatch = false
    
    // MARK: - BODY
    var body: some View {
        
        VStack(alignment: .leading){
            
            if isSecureField ?? false {

                Text(title)
                    .font(.callout)
                    .bold()
                SecureField(placeholderText, text: $text, onCommit: {
                    self.passwordStrength = checkPasswordStrength(password: text)
                    self.strongPassword = passwordStrength.contains("Strong")
                    self.passwordMatchMessage = checkPasswordsMatch(text, confirmPassword)
                })
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(width: 310, height: 65)
                    )
                    .frame(width: 310, height: 65, alignment: .center)
                    .foregroundColor(Color.white)

                if strongPassword == false && confirmText == false {
                    Text(passwordStrength)
                        .font(.caption2)
                }

                if confirmText == true {
                    Text(passwordMatchMessage)
                        .font(.caption2)
                }


            } else {
                TextField(placeholderText, text: $text)
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(width: 310, height: 65)
                    )
                    .frame(width: 310, height: 65, alignment: .center)
                    .foregroundColor(Color.white)
                
            }
            
        }//: VSTACK
        .padding()
    }

    func checkPasswordStrength(password: String) -> String {
        let passwordLength = password.count
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        let lowercaseLetters = CharacterSet.lowercaseLetters
        let uppercaseLetters = CharacterSet.uppercaseLetters

        // Check length
        if passwordLength < 8 {
            return "Weak password. Your password should be at least 8 characters long."
        }

        // Check for letters and digits
        if password.rangeOfCharacter(from: letters) == nil || password.rangeOfCharacter(from: digits) == nil {
            return "Weak password. Your password should contain both letters and digits."
        }

        // Check for lowercase and uppercase letters
        if password.rangeOfCharacter(from: lowercaseLetters) == nil || password.rangeOfCharacter(from: uppercaseLetters) == nil {
            return "Weak password. Your password should contain both lowercase and uppercase letters."
        }

        // Strong password
        return "Strong password!"
    }

    func checkPasswordsMatch(_ password1: String, _ password2: String) -> String {
        if password1 == password2 {
            return "Passwords match."
        } else {
            return "Passwords do not match."
        }
    }

    
}




//struct CustomInputTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInputTextField(isSecureField: false, placeholderText: "Testing this...", text: .constant(""))
//    }
//}
