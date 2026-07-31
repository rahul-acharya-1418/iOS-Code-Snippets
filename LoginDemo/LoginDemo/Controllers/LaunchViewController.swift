//
//  LaunchViewController.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 31/07/26.
//

import UIKit

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            AppRouter.setStartRoot()
        }
    }
}
