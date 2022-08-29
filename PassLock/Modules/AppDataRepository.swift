//
//  AppDetailModel.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 23/08/22.
//

import Foundation
struct AppDetailModel {
    var name : String
    let color : String?
    let webLink : String?
    let appLink : String = String()
    var isFav : Bool = false
}
struct AppData {
    static var shared = AppData()
    var appDetails : [AppDetailModel] = [
        AppDetailModel(name: "Facebook", color: "LightBlue", webLink: "https://www.facebook.com/"),
        AppDetailModel(name: "Instagram", color: "lightRed", webLink: "https://www.instagram.com/"),
        AppDetailModel(name: "Twitter", color: "lightBlue", webLink: "https://twitter.com/i/flow/login"),
        AppDetailModel(name: "PayPal", color: "lightBlue", webLink: "https://www.paypal.com/in/signin"),
        AppDetailModel(name: "Snapchat", color: "lightYellow", webLink: "https://accounts.snapchat.com/accounts/login"),
        AppDetailModel(name: "UpWork", color: "lightGreen", webLink: "https://www.upwork.com/ab/account-security/login"),
        AppDetailModel(name: "DropBox", color: "lightBlue", webLink: "https://www.dropbox.com/login"),
        AppDetailModel(name: "Gmail", color: "lightRed", webLink: "https://mail.google.com/mail/"),
        AppDetailModel(name: "Quora", color: "lightRed", webLink: "https://www.quora.com/login"),
        AppDetailModel(name: "Others", color: "lightBlue", webLink: nil)
    ]
    var selectedApps = [AppDetailModel]()
    var favAppDetails : [AppDetailModel] {
        selectedApps.filter { data in
            data.isFav
        }
    }
}
