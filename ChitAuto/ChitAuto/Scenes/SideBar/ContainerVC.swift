//
//  ContainerVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 20.07.24.
//

import UIKit

enum MenuState {
    case opened
    case closed
}

class ContainerViewController: UIViewController {
    
    let menuVC = MenuViewController()
    
    let welcomeView = WelcomeView()
    let welcomeViewModel = WelcomeViewModel()
    lazy var welcomeVC = WelcomeVC(welcomeView: welcomeView, welcomeViewModel: welcomeViewModel)
    
    var navVC: UINavigationController?
    
    private var menuState: MenuState = .closed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addChildVCs()
    }
    
    private func addChildVCs() {
        // Menu
        menuVC.menuViewControllerDelegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        menuVC.view.frame = CGRect(x: -view.frame.size.width * 0.8, y: 0, width: view.frame.size.width * 0.8, height: view.frame.size.height)
        
        welcomeVC.welcomeView.delegate = self
        let navVC = UINavigationController(rootViewController: welcomeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn) { [weak self] in
                guard let self = self else { return }
                self.navVC?.view.frame.origin.x = self.view.frame.size.width * 0.8
                self.menuVC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                guard let self = self else { return }
                if done {
                    self.menuState = .opened
                    completion?()
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn) { [weak self] in
                guard let self = self else { return }
                self.navVC?.view.frame.origin.x = 0
                self.menuVC.view.frame.origin.x = -self.view.frame.size.width * 0.8
            } completion: { [weak self] done in
                guard let self = self else { return }
                if done {
                    self.menuState = .closed
                    completion?()
                }
            }
        }
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelectMenuItem(menuItem: MenuOptions) {
        toggleMenu { [weak self] in
            switch menuItem {
            case .garage:
                guard let unwrappedUser = self?.welcomeViewModel.currentUser else { return }
                
                let userMainView = UserMainView()
                let userMainViewModel = UserMainViewModel(currentUser: unwrappedUser)
                
                userMainViewModel.onSelectedUserChanged = { [weak self] user in
                    self?.welcomeViewModel.currentUser = user
                }
                
                let vc = UserMainVC(userMainView: userMainView, userMainViewModel: userMainViewModel)

                self?.navVC?.pushViewController(vc, animated: true)
            case .carWash:
                print("carWash")
            case .profile:
                print("profile")
            case .signOut:
                self?.welcomeViewModel.signOut()
            }
        }
    }
}
