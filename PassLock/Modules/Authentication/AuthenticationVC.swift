//
//  LoginVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 02/08/22.
//

import UIKit
import MotionToastView

class AuthenticationVC: BaseVC {
    @IBOutlet private weak var numbersCollectionView: UICollectionView!
    @IBOutlet private weak var passTextField1: UITextField!
    @IBOutlet private weak var passTextField2: UITextField!
    @IBOutlet private weak var passTextField3: UITextField!
    @IBOutlet private weak var passTextField4: UITextField!
    @IBOutlet private weak var passTextField5: UITextField!
    @IBOutlet private weak var passTextField6: UITextField!
    @IBOutlet private weak var viewToShake: UIStackView!
    @IBOutlet private weak var wrongPasswordLabel: UILabel!
    private var password = String()
    private var allTextField = [UITextField]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionViewCell()
        allTextField = [passTextField1,passTextField2,passTextField3,passTextField4,passTextField5,passTextField6]
        passTextField1.becomeFirstResponder()
    }
    func setUpCollectionViewCell() {
        numbersCollectionView.delegate = self
        numbersCollectionView.dataSource = self
    }
    func enterPasswordIntoFields(value : String) {
        guard let currentIndex = allTextField.firstIndex(where: {$0.text?.isEmpty ?? true}) else { return }
        allTextField[currentIndex].text = value
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.allTextField[currentIndex].isSecureTextEntry = true
         }
        if currentIndex != allTextField.count - 1 {
            allTextField[currentIndex + 1].becomeFirstResponder()
        } else {
            checkPassword()
        }
    }
    func removePasswordFromFields() {
        guard let currentIndex = allTextField.lastIndex(where: { !($0.text?.isEmpty ?? true)}) else { return }
        allTextField[currentIndex].text = nil
        allTextField[currentIndex].isSecureTextEntry = false
        if currentIndex > 0 {
            allTextField[currentIndex - 1].becomeFirstResponder()
        }
    }
    func checkPassword() {
        guard let pass1 = passTextField1.text , let pass2 = passTextField2.text, let pass3 = passTextField3.text, let pass4 = passTextField4.text, let pass5 = passTextField5.text , let pass6 = passTextField6.text else { return }
        self.password = pass1 + pass2 + pass3 + pass4 + pass5 + pass6
        if password == "123456" {
            passTextField6.resignFirstResponder()
            let controller = HomeVC.instantiate(fromAppStoryboard: .postlogin)
            performNavigation(controller: controller)
        } else {
            wrongPasswordLabel.isHidden = false
            shakeTextFields()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.changeBorderColor(color: .white)
                self.wrongPasswordLabel.isHidden = true
                self.allTextField.forEach({$0.text = nil; $0.isSecureTextEntry = false})
                self.passTextField1.becomeFirstResponder()
            }
        }
    }
    func shakeTextFields() {
        changeBorderColor(color: .red)
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.09
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x - 10, y: viewToShake.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x + 10, y: viewToShake.center.y))
        viewToShake.layer.add(animation, forKey: "position")
    }
    func changeBorderColor(color : UIColor) {
        allTextField.forEach { $0.borderColor = color }
    }
}
extension AuthenticationVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumbersCollectionViewCell.identifier, for: indexPath) as? NumbersCollectionViewCell else { return UICollectionViewCell()}
        cell.fillNumber(row: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 45
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.height / 12
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 9 :
            return
        case 10 :
            enterPasswordIntoFields(value : "0")
        case 11 :
            removePasswordFromFields()
        default :
            enterPasswordIntoFields(value : "\(indexPath.row + 1)")
        }
    }
}
