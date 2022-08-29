//
//  SignUpVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 02/08/22.
//

import UIKit
import Foundation
import MotionToastView

class CreateAccountVC: BaseVC {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    var createAccountVM : CreateAccountVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
    }
}
private extension CreateAccountVC {
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        guard let name = nameTextField.text , let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else { return }
        let details = AccountModel(name: name, email: email, password: password, confirmPassword: confirmPassword)
        createAccountVM = CreateAccountVM(data: details)
        switch createAccountVM.checkInputValidations() {
        case .correct :
            UserDefaults.standard.set(true, forKey: "isAccountCreated")
            MotionToast(message: "Account Created Successfully", toastType: .success, duration: .short, toastStyle: .style_vibrant, toastGravity: .top, toastCornerRadius: 5, pulseEffect: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let controller = HomeVC.instantiate(fromAppStoryboard: .postlogin)
                self.performNavigation(controller: controller)
            }
        case .incorrect :
            MotionToast(message: createAccountVM.warningMessage, toastType: .warning, duration: .short, toastStyle: .style_vibrant, toastGravity: .top, toastCornerRadius: 5, pulseEffect: false)
        }
    }
}
extension CreateAccountVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0 {
              return true
            }
        let currentText = textField.text ?? String()
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        switch textField {
        case passwordTextField :
            return prospectiveText.isNumeric && prospectiveText.count <= 6 && prospectiveText != "0"
        case confirmPasswordTextField :
            return prospectiveText.isNumeric && prospectiveText.count <= 6 && prospectiveText != "0"
        default :
            return true
        }
    }
}
