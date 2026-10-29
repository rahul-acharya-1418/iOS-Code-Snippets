//
//  ViewController.swift
//  The-Swift-Programming-Language
//
//  Created by Rahul Acharya on 29/10/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = TheBasicsViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
}
