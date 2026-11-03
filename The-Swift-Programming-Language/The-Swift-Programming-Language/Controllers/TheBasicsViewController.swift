//
//  TheBasicsViewController.swift
//  The-Swift-Programming-Language
//
//  Created by Rahul Acharya on 29/10/26.
//

import UIKit

class TheBasicsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TheBasics"
        /// `In Progress`: https://docs.swift.org/latest/documentation/the-swift-programming-language/thebasics/#Type-Annotations
    }
}

extension TheBasicsViewController {
    
    /// This code can be read as:
    /// Declare a new constant called maximumNumberOfLoginAttempts, and give it a value of 10. Then, declare a new variable called currentLoginAttempt, and give it an initial value of 0.
    func declaringConstantsAndVariables1() {
        let maximumNumberOfLoginAttempts: Int = 10
        var currentLoginAttempts: Int = 0
        
    }
    
    /// the maximum number of login attempts is constant, and its value depends on the environment. In the development environment, it has a value of 100; in any other environment, its value is 10. Both branches of the if statement initialize maximumNumberOfLoginAttempts with some value, guaranteeing that the constant always gets a value.
    func declaringConstantsAndVariables2() {
        let maximumNumberOfLoginAttempts: Int
        var environment = "development"
        
        if environment == "development" {
            maximumNumberOfLoginAttempts = 100
        } else {
            maximumNumberOfLoginAttempts = 10
        }
        // Now maximumNumberOfLoginAttempts has a value, and can be read.

        // You can declare multiple constants or multiple variables on a single line, separated by commas:
        
        var x = 0.0, y = 0.0, z = 0.0
    }
    
    func asdf() {
        /// Variable, Constant, Static
        var str = "Hello World"
        var x = 4
        var y = 1
        let z = 3
    }
}
