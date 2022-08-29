//
//  CreateAccountVM.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 10/08/22.
//

import Foundation
struct CreateAccountVM {
    private var accountData : AccountModel
    var warningMessage = String()
    init(data : AccountModel) {
        self.accountData = data
    }
    mutating func checkInputValidations() -> InputStatus {
        if accountData.name.isEmpty {
            warningMessage = StringConstant.CreateAccountWarnings.nameEmpty.rawValue
            return .incorrect
        } else if accountData.email.isEmpty {
            warningMessage = StringConstant.CreateAccountWarnings.mailEmpty.rawValue
            return .incorrect
        } else if !accountData.email.isValidEmail() {
            warningMessage = StringConstant.CreateAccountWarnings.validMail.rawValue
            return .incorrect
        } else if accountData.password.isEmpty {
            warningMessage = StringConstant.CreateAccountWarnings.passEmpty.rawValue
            return .incorrect
        }else if accountData.password.count < 6  {
            warningMessage = StringConstant.CreateAccountWarnings.passLengthError.rawValue
            return .incorrect
        } else if accountData.confirmPassword.isEmpty || accountData.confirmPassword != accountData.password {
            warningMessage = StringConstant.CreateAccountWarnings.notMatch.rawValue
            return .incorrect
        } else {
            return .correct
        }
    }
}
enum InputStatus {
    case correct
    case incorrect
}
