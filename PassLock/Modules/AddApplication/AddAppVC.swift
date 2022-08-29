//
//  AddAppVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 08/08/22.
//

import UIKit
import DropDown
var reloadClosure : (() -> Void)?
class AddAppVC: UIViewController {
    
    @IBOutlet private weak var chooseAppLabel: UILabel!
    @IBOutlet private weak var otherAppTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPassWordTextField: UITextField!
    private var dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - IBActions of buttons
private extension AddAppVC {
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func showPasswordButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0 :
            sender.isSelected.toggle()
            passwordTextField.isSecureTextEntry.toggle()
        case 1 :
            sender.isSelected.toggle()
            confirmPassWordTextField.isSecureTextEntry.toggle()
        default :
            return
        }
    }
    @IBAction func chooseAppButtonPressed(_ sender: UIButton) {
        dropDown.dataSource = AppData.shared.appDetails.map({$0.name})
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            if index == (self?.dropDown.dataSource.count ?? 1) - 1 {
                self?.chooseAppLabel.textColor = .placeholderText
                self?.chooseAppLabel.text = "Choose App"
                UIView.animate(withDuration: 0.2) {
                    self?.otherAppTextField.isHidden = false
                }
            } else {
                self?.chooseAppLabel.textColor = .black
                self?.chooseAppLabel.text = item
                UIView.animate(withDuration: 0.2) {
                    self?.otherAppTextField.isHidden = true
                }
            }
        }
    }
    @IBAction func addApplicationButtonPressed(_ sender: UIButton) {
        guard let appName = chooseAppLabel.text, !appName.isEmpty, let pass = passwordTextField.text, let confirmPass = confirmPassWordTextField.text, let otherAppName = otherAppTextField.text else { return }
        let index = AppData.shared.appDetails.firstIndex(where: {$0.name == appName || $0.name.lowercased() == otherAppName.lowercased()})
        if let actualIndex = index {
            let data = AppData.shared.appDetails[actualIndex]
            if !AppData.shared.selectedApps.contains(where: {$0.name == data.name}) {
                AppData.shared.selectedApps.append(data)
            } else {
                MotionToast(message: "App is Already selected", toastType: .info, duration: .short, toastStyle: .style_vibrant, toastGravity: .top, toastCornerRadius: 5, pulseEffect: false)
            }
        } else {
            let data = AppDetailModel(name: otherAppName, color: "lightBlue", webLink: nil)
            if !AppData.shared.selectedApps.contains(where: {$0.name.lowercased() == otherAppName.lowercased()}) {
                AppData.shared.selectedApps.append(data)
            } else {
                MotionToast(message: "App is Already selected", toastType: .info, duration: .short, toastStyle: .style_vibrant, toastGravity: .top, toastCornerRadius: 5, pulseEffect: false)
            }
        }
        debugPrint(pass,confirmPass)
        reloadClosure?()
        self.dismiss(animated: true)
    }
}
