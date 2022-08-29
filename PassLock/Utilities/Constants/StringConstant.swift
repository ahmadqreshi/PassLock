//
//  StringConstant.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 01/08/22.
//

import Foundation
enum StringConstant {
    enum TutorialLabels : String, CaseIterable {
        case label1 = "Pass Locks keeps your password safe"
        case label2 = "Pass Locks stores password into Keychains"
        case label3 = "Pass Locks Provide maximum security for keeping password"
    }
    enum CollectionViewIdentifiers : String {
        case tutorialCollectionViewCell = "TutorialCollectionViewCell"
    } 
    enum CreateAccountWarnings : String {
        case nameEmpty = "Name field is Empty"
        case mailEmpty = "Email field is Empty"
        case validMail = "Please Enter Valid Mail"
        case passEmpty = "Password filed is Empty"
        case passLengthError = "Password length must be of 6 character"
        case notMatch = "Password does not match"
    }
}
