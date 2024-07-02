//
//  SceneDelegate.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 01.07.24.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let onBoarding = OnBoardingVC(onBoardingView: OnBoardingView(), onBoardingViewModel: OnBoardingViewModel())
        let navigatorController = UINavigationController(rootViewController: onBoarding)
        window?.rootViewController = navigatorController
        window?.makeKeyAndVisible()
    }
}

