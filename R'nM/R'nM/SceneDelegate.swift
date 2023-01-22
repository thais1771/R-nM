//
//  SceneDelegate.swift
//  R'nM
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Extensions
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)

        let viewController = ListViewController()
        let navigatinController = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigatinController
        self.window = window

        window.makeKeyAndVisible()
    }
}
