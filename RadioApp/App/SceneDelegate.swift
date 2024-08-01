//
//  SceneDelegate.swift
//  RadioApp
//
//  Created by MacUser on 27.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        start()
    }
    
    func start() {
        setRootViewController(makeWelcome())
    }

    func setRootViewController(_ controller: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = controller
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    private func makeWelcome() -> UIViewController {
        let controller = WelcomeViewController()
        controller.action = { [weak self] in
            guard let self else { return }
            self.setRootViewController(self.makeMain())
        }
        return controller
    }
    
    private func makeMain() -> UIViewController {
        let controller = ProfileViewController()
        return UINavigationController(rootViewController: controller)
    }

}

