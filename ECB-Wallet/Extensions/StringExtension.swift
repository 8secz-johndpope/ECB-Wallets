//
//  StringExtension.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import Foundation

import Validator
extension String {
    
    // Validate Password
    func isValidatePassword(completionHandler:@escaping(_ error:String?) -> Void){
        var passwordRules = ValidationRuleSet<String>()
        let maxLengthRule = ValidationRuleLength(max: 6, error: ExampleValidationError("Password is must only contain 6 numbers"))
        passwordRules.add(rule: maxLengthRule)
        let digitPattern = ContainsNumberValidationPattern()
        let integerRequestRule = ValidationRulePattern(pattern: digitPattern, error: ExampleValidationError("Password is must only contain 6 numbers"))
        passwordRules.add(rule: integerRequestRule)
        let result = self.validate(rules: passwordRules)
        switch result {
        case .valid:
            print("True")
            completionHandler(nil)
        case .invalid(let failures):
            print(failures.first?.message)
            completionHandler(failures.first?.message)
        default:
            return
        }
    }
    //Valadate email
    func isValadateEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    //Valadate password
    func isValadatePasswprd() -> Bool {
        return self.range(of: "^[0-9]{6,6}$", options: .regularExpression) != nil
    }
    //Capitalizing First Letter
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + dropFirst()
    }
}
