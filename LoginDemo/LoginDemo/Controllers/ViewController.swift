//
//  ViewController.swift
//  LoginDemo
//
//  Created by Rahul Acharya on 31/07/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var login: AppButton!
    @IBOutlet weak var signUp: AppButton!
    @IBOutlet weak var guest: AppButton!
    @IBOutlet weak var titleLabel: AppLabel!
    @IBOutlet weak var descriptionLabel: AppLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        //        emailTextField.leftViewMode = .always
        //
        //        emailTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        //        emailTextField.rightViewMode = .always
        signUp.fullText = "Don't have an account? Create Account"
        signUp.rangeText = "Create Account"
        login.buttonStyle = .primary
        signUp.buttonStyle = .secondary
        guest.buttonStyle = .guest
        titleLabel.labelStyle = .title
        descriptionLabel.labelStyle = .description
    }
}
