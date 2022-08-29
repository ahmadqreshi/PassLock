//
//  Stoyboards.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 02/08/22.
//
import Foundation
import UIKit
enum Storyboards : String {
    case prelogin = "PreLogin"
    case postlogin = "PostLogin"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
extension Storyboards {
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard")
        }
        return scene
    }
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: Storyboards) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
