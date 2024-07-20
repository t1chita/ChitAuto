//
//  SceneDelegate.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 01.07.24.
//
import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        if Auth.auth().currentUser != nil {
            showWelcomeVC()
        } else {
            showOnBoardingVC()
        }
        
        window?.makeKeyAndVisible()
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil {
                self?.showWelcomeVC()
            } else {
                self?.showOnBoardingVC()
            }
        }
    }
    
    private func showWelcomeVC() {
        window?.rootViewController = ContainerViewController()
    }
    
    private func showOnBoardingVC() {
        let onBoardingVC = OnBoardingVC(onBoardingView: OnBoardingView(), onBoardingViewModel: OnBoardingViewModel())
        let navigatorController = UINavigationController(rootViewController: onBoardingVC)
        window?.rootViewController = navigatorController
    }
}

