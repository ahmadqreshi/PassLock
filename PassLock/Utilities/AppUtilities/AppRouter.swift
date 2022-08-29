//
//  AppRouter.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 10/08/22.
//
import Foundation
import UIKit

struct AppRouter {
    // MARK: - Function to check app initialization flow
    static func checkAppinitalizationFlow() {
        if let _ = UserDefaults.standard.object(forKey: "isTutorialDisplated") {
            if let _ = UserDefaults.standard.object(forKey: "isAccountCreated") {
                loadAuthenticationScreen()
            } else {
                loadIntroScreen()
            }
        } else {
            loadTutorialScreen()
        }
    }
    // MARK: - Function to move to Tutorial Screen
    static func loadTutorialScreen() {
        let landingScene = TutorialVC.instantiate(fromAppStoryboard: .prelogin)
        let navigationController = UINavigationController(rootViewController: landingScene)
        setRoot(viewController: navigationController)
    }

    // MARK: - Function to move to prelogin screen
    static func loadIntroScreen() {
        let landingScene = IntroVC.instantiate(fromAppStoryboard: .prelogin)
        let navigationController = UINavigationController(rootViewController: landingScene)
        setRoot(viewController: navigationController)
    }

    // MARK: - Function to move to Menu Home Screen
    static func loadAuthenticationScreen() {
        let landingScene = AuthenticationVC.instantiate(fromAppStoryboard: .prelogin)
        let navigationController = UINavigationController(rootViewController: landingScene)
        navigationController.navigationBar.isHidden = true
        setRoot(viewController: navigationController)
    }

    // MARK: - Function to set root view controller
    static func setRoot(viewController : UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        sceneDelegate.window?.rootViewController = viewController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
