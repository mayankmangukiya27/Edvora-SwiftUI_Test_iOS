//
//  ValidationViewModel.swift
//  swiftuiTask
//
//  Created by Shubham on 23/11/21.
//

import Foundation

class validationViewModel: ObservableObject {
    @Published var userName = ""
    @Published var password = ""
    @Published var email = ""
  
    // MARK: - Validation Functions
    
    func notEmpty() -> Bool{
        if userName.isEmpty || password.isEmpty || email.isEmpty {
            return  false
        }
        return true
    }
    
    func isPasswordValid(_ string: String) -> Bool {
        // criteria in regex.  See http://regexlib.com
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    
//    var isLoginComplete: Bool {
//        if !isPasswordValid() ||
//        !isEmailValid() {
//            return false
//        }
//        return true
//    }
    
//    // MARK: - Validation Prompt Strings
//
//

    var emailPrompt: String {
        if isEmailValid(email) {
            return ""
        } else {
            return "Enter a valid email address"
        }
    }


    var emptyPrompt: String {
        if notEmpty() {
            return ""
        } else {
            return "Empty field not Valid"
        }
    }

    var passwordPrompt: String {
        if isPasswordValid(password) {
            return ""
        } else {
            return "Must be between 8 and 15 characters containing at least one number and one capital letter"
        }
    }


    func signUp() {
        // perform signup functions then clear fields
        email = ""
        password = ""
    }
}
