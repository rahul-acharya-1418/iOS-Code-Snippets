//
//  AppRouter.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 31/07/26.
//

import UIKit

final class AppRouter {

    private static var window: UIWindow?

    static func configure(window: UIWindow) {
        self.window = window
    }
    
    static func setLaunchRoot() {
        let viewController = AppStoryboard.main.instantiateViewController(LaunchViewController.self)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    static func setStartRoot() {
        let viewController = AppStoryboard.main.instantiateViewController(ViewController.self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
